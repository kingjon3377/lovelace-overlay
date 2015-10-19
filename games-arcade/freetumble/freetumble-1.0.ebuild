# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games toolchain-funcs scons-utils

MY_PN=FreeTumble

DESCRIPTION="Clear a grid of stones by color"
HOMEPAGE="http://freetumble.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${MY_PN}V${PV}_src.tar.gz
	mirror://sourceforge/${PN}/${PV}/${MY_PN}V${PV}_Linux32.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/libsfml"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_configure() {
	myesconsargs=(
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
	)
}

src_compile() {
	escons
}

src_install() {
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data
	doins ${MY_PN}
	fperms +x "${GAMES_DATADIR}/${PN}/${MY_PN}"
	fowners :${GAMES_GROUP} "${GAMES_DATADIR}/${PN}/data/scores.dat" \
		"${GAMES_DATADIR}/${PN}/data/game.ini"
	fperms g+w "${GAMES_DATADIR}/${PN}/data/scores.dat" \
		"${GAMES_DATADIR}/${PN}/data/game.ini"
	cat > "${T}/wrapper.sh" <<-EOF
#!/bin/sh
cd "${GAMES_DATADIR}/${PN}"
./${MY_PN}
EOF
	newgamesbin "${T}/wrapper.sh" ${PN}
	dodoc README
}
