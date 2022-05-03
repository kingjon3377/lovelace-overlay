# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit autotools

DESCRIPTION="A DAAP (iTunes) media server"
HOMEPAGE="https://github.com/owntone/owntone-server"
SRC_URI="https://github.com/${PN}/${PN}-server/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="lastfm mpd webinterface chromecast spotify pulseaudio"

# Note: mpd support appears to be standalone, e.g. --enable-mpd doesn't
# result in additional linkage.
RDEPEND="
	acct-user/daapd
	acct-group/daapd
	dev-db/sqlite:3
	dev-libs/antlr-c:0
	dev-libs/confuse
	dev-libs/libevent
	dev-libs/libgcrypt:0
	dev-libs/libunistring
	dev-libs/mxml[threads]
	sys-libs/zlib
	dev-libs/json-c
	media-libs/alsa-lib
	net-dns/avahi[dbus]
	media-video/ffmpeg
	dev-libs/libsodium

	app-pda/libplist
	lastfm? ( net-misc/curl )
	webinterface? ( net-libs/libwebsockets )
	pulseaudio? ( || ( media-libs/libpulse media-sound/pulseaudio ) )
	chromecast? ( net-libs/gnutls )
	spotify? ( dev-libs/protobuf-c )
"

DEPEND="${RDEPEND}"

BDEPEND="sys-devel/gettext
	dev-util/gperf
	sys-devel/bison
	sys-devel/flex
	dev-java/antlr:3
	webinterface? ( net-libs/nodejs )"

S="${WORKDIR}/${PN}-server-${PV}"

pkg_pretend() {
	use webinterface && die "Web interface build not yet supported"
}

src_prepare() {
	eapply_user
	eautoreconf
}

src_configure() {
	econf --sysconfdir=/etc --localstatedir=/var \
		--with-alsa \
		$(use_enable lastfm) \
		$(use_enable mpd) \
		$(use_enable webinterface) \
		$(use_enable spotify) \
		$(use_enable chromecast) \
		$(use_enable pulseaudio) \
		--disable-verification
}

src_install() {
	emake DESTDIR="${D}" install

	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}

	# dodir by itself fails in the likely case of /srv/music having a
	# volume mounted already.
	if ! test -d /srv/music ; then
		dodir /srv/music
		keepdir /srv/music
	fi
}
