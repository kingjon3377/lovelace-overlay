# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy2_0 )

inherit distutils-r1

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Zope testrunner script."
HOMEPAGE="https://pypi.python.org/pypi/zope.testrunner"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# net-zope/namespaces-zope[zope]
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	net-zope/zope-exceptions[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	!<net-zope/zope-testing-3.10.0"
RDEPEND="${DEPEND}"

DOCS="CHANGES.rst README.rst"
PYTHON_MODULES="${PN/.//}"

src_install() {
	distutils-r1_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/zope/testrunner/tests"
	}
	python_foreach_impl delete_tests
}
