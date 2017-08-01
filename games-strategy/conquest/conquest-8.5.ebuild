# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit games autotools eutils toolchain-funcs

DESCRIPTION="a real-time, multi-player space warfare game"
HOMEPAGE="http://conq.sourceforge.net"
SRC_URI="mirror://sourceforge/conq/${P}.src.tar.gz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="+opengl"

DEPEND="sys-libs/ncurses:0
	opengl? ( media-libs/freeglut
		media-libs/sdl-mixer )"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup conquest
}

src_prepare() {
	eautoreconf
}

src_configure() {
	local myconf="--disable-tcpwrappers"
	use opengl || myconf="${myconf} --disable-gl --disable-sound --without-x"
	econf CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" ${myconf}
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodir /usr/games
	mv -i "${D}/usr/bin/" "${D}"/usr/games/bin
	mv -i "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${P}"
}
