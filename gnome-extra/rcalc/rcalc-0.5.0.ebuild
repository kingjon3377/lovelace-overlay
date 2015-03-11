# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils gnome2 toolchain-funcs #autotools

DESCRIPTION="graphical symbolic calculator"
HOMEPAGE="http://rcalc.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="media-libs/libart_lgpl
	x11-libs/cairo
	gnome-base/gconf
	gnome-base/libglade
	gnome-base/libgnome
	gnome-base/libgnomeui
	gnome-base/libgnomecanvas
	gnome-base/gnome-vfs
	sys-libs/readline
	sys-libs/libtermcap-compat
	gnome-base/libbonoboui"
RDEPEND="${DEPEND}"

src_prepare() {
	cd "${WORKDIR}" && epatch "${FILESDIR}/rcalc_0.5.0-1.3.diff"
	cd "${S}" && epatch debian/patches/*diff
	sed -i -e 's:grcalc:rcalc:g' debian/grcalc.1 || die "sed failed"
}

src_configure() {
	ewarn "If configuration fails because it claims it can\'t find readline,"
	ewarn "creating a libtermcap.so link will probably fix it."
	econf --enable-term-ui
}

src_install() {
	gnome2_src_install
	dodoc AUTHORS ChangeLog NEWS README
	newman debian/grcalc.1 rcalc.1
}
