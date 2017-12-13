# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Copyright 1999-2015 Tiziano Müller

EAPI=5

inherit autotools eutils

DESCRIPTION="User Interface to the stochastic system profiler using a server/client model."
HOMEPAGE="http://labs.o-hand.com/oprofileui/"
SRC_URI="http://labs.o-hand.com/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="avahi +client"

RDEPEND="dev-libs/glib:2
	avahi? ( net-dns/avahi )
	client? ( gnome-base/libglade
		x11-libs/gtk+:2
		dev-libs/libxml2:2
		gnome-base/gnome-vfs:2
		gnome-base/gconf:2 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}/${PV}-autoconf.patch"
	eautoreconf
}

src_configure() {
	econf \
		--enable-server \
		$(use_enable client) \
		$(use_with avahi)
}

src_install() {
	emake DESTDIR="${D}" install

	rm -rf "${D}/usr/share/doc/oprofileui"
	dodoc AUTHORS ChangeLog NEWS README
}
