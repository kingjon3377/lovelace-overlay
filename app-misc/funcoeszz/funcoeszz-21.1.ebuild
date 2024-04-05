# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="script with 65 useful mini applications"
HOMEPAGE="https://funcoeszz.net/"
SRC_URI="https://${PN}.net/download/${P}.sh"

S=${WORKDIR}
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="www-client/lynx"

src_unpack() {
	pushd "${DISTDIR}" > /dev/null
	cp -i ${A} "${WORKDIR}"
	popd > /dev/null
}

src_install() {
	newbin ${A} ${PN}
	doman "${FILESDIR}/funcoeszz.1"
}
