# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 2.6"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"

PYTHON_COMPAT=( python2_7 python3_{2,3,4} )

inherit distutils-r1

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="zope.interface extension for defining data schemas"
HOMEPAGE="http://pypi.python.org/pypi/zope.schema"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

# net-zope/namespaces-zope[${PYTHON_USEDEP}]
RDEPEND="
	net-zope/zope-event[${PYTHON_USEDEP}]
	>=dev-python/zope-interface-3.6.0[${PYTHON_USEDEP}]
	net-zope/zope-i18nmessageid[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( net-zope/zope-testing[${PYTHON_USEDEP}] )"

DOCS="CHANGES.rst README.rst"
PYTHON_MODULES="${PN/.//}"

src_compile() {
	distutils-r1_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		emake html
		popd > /dev/null
	fi
}

python_test() {
	esetup.py test
}

src_install() {
	distutils-r1_src_install

	if use doc; then
		dohtml -r docs/_build/html/
	fi
}
