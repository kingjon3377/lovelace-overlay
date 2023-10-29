# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Clear a grid of stones by color"
HOMEPAGE="https://gitlab.com/LibreGames/freetumble"
SRC_URI="https://gitlab.com/LibreGames/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/libsfml"
DEPEND="${RDEPEND}
	app-alternatives/bzip2"

PATCHES=(
	"${FILESDIR}/${P}-0001-Fix-build-with-SFML-2.5.0.patch"
	"${FILESDIR}/${P}-fhs-paths.patch"
)

#CMAKE_MAKEFILE_GENERATOR=emake

src_prepare() {
	cmake_src_prepare
	sed -i -e "s#@@PF@@#${PF}#" CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DFOR_INSTALL=ON
	)

	cmake_src_configure
}
