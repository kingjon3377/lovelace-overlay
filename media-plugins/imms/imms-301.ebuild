# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils autotools toolchain-funcs multilib

DESCRIPTION="Adaptive playlist framework that tracks your listening patterns and dynamically adapts to your taste"
HOMEPAGE="http://www.luminal.org/wiki/index.php/IMMS/IMMS"
SRC_URI="http://imms.googlecode.com/files/${PN}-r${PV}.tar.bz2"

LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vorbis remote"
DEPEND=">=dev-db/sqlite-3
	>=dev-libs/glib-2
	dev-libs/libpcre
	|| ( media-libs/id3lib media-libs/taglib )
	>=sci-libs/fftw-3.0
	sci-libs/torch
	media-sound/sox
	remote? ( >=gnome-base/libglade-2.0 >=x11-libs/gtk+-2 )
	vorbis? ( media-libs/libvorbis )
	media-sound/audacious"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-r${PV}"

src_prepare() {
	default_src_prepare
	epatch "${FILESDIR}/audacious-3.x.patch"
#	sed -i -e 's:auddrct.h:drct.h:' configure.ac || die "sed failed"
#	sed -i -e 's:audacious_drct_playqueue_add:audacious_drct_pq_add:' \
#		configure.ac clients/audacious/audplugin.cc || die "sed failed"
#	sed -i -e 's:-laudacious :-laudcore :' configure.ac || die "sed failed"
#	epatch "${FILESDIR}/imms-audacious.patch" || die "patch failed"
#	epatch "${FILESDIR}/imms-glib.patch" || die "second patch failed"
##	sed -i -e 's:DEBUG:ERROR:' immscore/fetcher.cc || die "sed failed"
#	sed -i -e 's:-fno-rtti::' vars.mk.in || die "second sed failed"
	CC="$(tc-getCC) ${CFLAGS} -pedantic" CXX="$(tc-getCXX) ${CXXFLAGS} -pedantic" eautoreconf
}

src_configure() {
	CC="$(tc-getCC) ${CFLAGS} -pedantic" CXX="$(tc-getCXX) ${CXXFLAGS} -pedantic" econf \
		--enable-analyzer \
		$(use_enable remote immsremote ) \
		$(use_with vorbis )
}

src_compile() {
	CC="$(tc-getCC) ${CFLAGS} -pedantic" CXX="$(tc-getCXX) ${CXXFLAGS} -pedantic" emake
}

src_install() {
		dobin build/immsd
		dobin build/immstool
		dobin build/analyzer
		use remote && dobin build/immsremote && insinto /usr/share/${PN} && doins immsremote/immsremote.glade
		exeinto "/usr/$(get_libdir)/audacious/General"
		doexe build/libaudaciousimms*.so
		dodoc README AUTHORS
}
