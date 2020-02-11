# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )
inherit distutils-r1

MY_P=${PN}_${PV}+nmu1

DESCRIPTION="Python library for generating dictd dictionaries"
HOMEPAGE="https://packages.debian.org/sid/python-dictdlib"
SRC_URI="mirror://debian/pool/main/d/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

#DEPEND=""
#RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}+nmu1"

PATCHES=( "${FILESDIR}/${P}-python3.patch" )

# TODO: Put those in DOCS (checking what's there already ...) so we can use default_src_install
src_install() {
	distutils-r1_src_install
	dodoc ${PN}.txt ${PN}.html
}
