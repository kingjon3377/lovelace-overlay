# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

MY_PN="RestrictedPython"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A restricted execution environment for Python, e.g. for running untrusted code"
HOMEPAGE="http://pypi.python.org/pypi/RestrictedPython"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

DEPEND="app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt src/RestrictedPython/README.txt"
PYTHON_MODULES="${MY_PN}"

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}
