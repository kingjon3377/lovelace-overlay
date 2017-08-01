# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )
inherit distutils-r1

MY_P=${PN}_${PV}

DESCRIPTION="Python library for generating dictd dictionaries"
HOMEPAGE="http://packages.debian.org/sid/python-dictdlib"
SRC_URI="mirror://debian/pool/main/d/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

#DEPEND=""
#RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-2.0.4"

src_install() {
	distutils-r1_src_install
	dodoc ${PN}.txt
	dohtml ${PN}.html
}
