# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="a puzzle game inspired by Tetris"
HOMEPAGE="https://blockattack.net/"
SRC_URI="https://github.com/${PN}/${PN}-game/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-game-${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-games/physfs
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	dev-libs/libfmt
	dev-libs/utfcpp"
DEPEND="${RDEPEND}
	dev-libs/boost"

PATCHES=( "${FILESDIR}/${PN}-2.6.0-utf8cpp.patch" "${FILESDIR}/${P}-no-compress-man.patch" )

src_configure() {
	local mycmakeargs=(
		-DBLOCKATTACK_USE_EMBEDDED_FMT=OFF
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	./packdata.sh || die
}

src_install() {
	cmake_src_install
	# TODO: Package this library separately
	dolib.so "${BUILD_DIR}/source/misc/embedded_libs/PlatformFolders-4.2.0/libplatform_folders.so"
}
