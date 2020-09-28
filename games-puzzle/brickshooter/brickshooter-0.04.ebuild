# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit wrapper

DESCRIPTION="small puzzle game about clearing blocks from a central area"
HOMEPAGE="https://linux.softpedia.com/get/GAMES-ENTERTAINMENT/Puzzle/brickshooter-37619.shtml"
SRC_URI="https://mirror.amdmi3.ru/distfiles/brickshooter-0.04.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/libsdl"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dodir /usr/share/${PN}
	exeinto /usr/share/${PN}
	doexe ${PN}
	insinto /usr/share/${PN}
	doins -r gfx levels snd
	make_wrapper ${PN} ${PN} /usr/share/${PN}
	insinto /usr/share/applications
	doins "${FILESDIR}/${PN}.desktop"
	insinto /usr/share/pixmaps
	doins "${FILESDIR}/${PN}.png"
}
