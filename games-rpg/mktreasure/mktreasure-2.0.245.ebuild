# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games

DESCRIPTION="Random d20 treasure generator"
HOMEPAGE="http://www.ajs.com/~ajs/cgi-bin/mktreasure.cgi"
SRC_URI="http://www.ajs.com/~ajs/${P}.tar.gz"

LICENSE="OGL"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-perl/YAML-Syck"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	dodir "${GAMES_DATADIR}/${PN}"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r ${PN} d20-treasure/
	fperms +x "${GAMES_DATADIR}/${PN}/${PN}"
	dogamesbin "${FILESDIR}/${PN}"
	dodoc d20-treasure/README
}
