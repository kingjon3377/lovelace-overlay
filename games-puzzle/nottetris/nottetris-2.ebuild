# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils games

DESCRIPTION="A 'spiritual successor' to Tetris, with physics"
HOMEPAGE="http://stabyourself.net/nottetris2"
SRC_URI="http://stabyourself.net/dl.php?file=${PN}${PV}/${PN}${PV}-linux.zip -> ${P}.zip"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="games-engines/love:0.7"
DEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	local dir="${GAMES_DATADIR}/love/${PN}"
	exeinto "${dir}"
	newexe "Not Tetris ${PV}.love" "${PN}.love"
	dodoc README
	newdoc "Not Readme.txt" Not_Readme.txt
	games_make_wrapper ${PN} "love-0.7 ${PN}.love" "${dir}"
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
}

pkg_postinst() {
	games_pkg_postinst
}
