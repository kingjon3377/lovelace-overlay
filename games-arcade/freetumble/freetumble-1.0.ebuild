# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs scons-utils

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
	insinto "/usr/share/${PN}"
	doins -r data
	# TODO: Binary should probably go in /usr/libexec
	doins ${MY_PN}
	fperms +x "/usr/share/${PN}/${MY_PN}"
	fowners :games "/usr/share/${PN}/data/scores.dat" \
		"/usr/share/${PN}/data/game.ini"
	fperms g+w "/usr/share/${PN}/data/scores.dat" \
		"/usr/share/${PN}/data/game.ini"
	cat > "${T}/wrapper.sh" <<-EOF
#!/bin/sh
cd "/usr/share/${PN}"
./${MY_PN}
EOF
	newbin "${T}/wrapper.sh" ${PN}
	dodoc README
}
