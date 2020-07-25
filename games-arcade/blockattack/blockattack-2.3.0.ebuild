# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="a puzzle game inspired by Tetris"
HOMEPAGE="http://blockattack.sf.net"
SRC_URI="https://github.com/${PN}/${PN}-game/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-games/physfs
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	dev-libs/utfcpp"
DEPEND="${RDEPEND}
	dev-libs/boost"

S="${WORKDIR}/${PN}-game-${PV}"

src_compile() {
	default
	./packdata.sh || die
}
