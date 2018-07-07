# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="script with 65 useful mini applications"
HOMEPAGE="http://funcoeszz.net/"
SRC_URI="http://${PN}.net/download/${P}.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="www-client/lynx"
DEPEND=""

S=${WORKDIR}

src_unpack() {
	pushd "${DISTDIR}" > /dev/null
	cp -i ${A} "${WORKDIR}"
	popd > /dev/null
}

src_install() {
	newbin ${A} ${PN}
	doman "${FILESDIR}/funcoeszz.1"
}
