# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Lightweight curses spreadsheet based on GNU oleo"
HOMEPAGE="https://github.com/blippy/neoleo"
SRC_URI="https://github.com/blippy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="sys-libs/ncurses:0"
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig"

src_prepare() {
	default
	sed -i -e \
		's@neoleo.1 DESTINATION ${CMAKE_INSTALL_PREFIX}/man/man1@neoleo.1 DESTINATION ${CMAKE_INSTALL_PREFIX}/share/man/man1@' \
		doc/CMakeLists.txt doc/Man.cmake || die
	cmake_src_prepare
}

src_test() {
	TZ=UTC cmake_src_test
}
