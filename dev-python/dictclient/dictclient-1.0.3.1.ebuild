# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_5,2_6,2_7} )
inherit distutils-r1

DESCRIPTION="Library for interacting with DICTD servers"
HOMEPAGE="gopher://quux.org/1/devel/dictclient."
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

#DEPEND=""
#RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-1.0.3"

src_install() {
	distutils-r1_src_install
	dodoc ${PN}.txt ${PN}.html
}
