# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5"
PYTHON_TESTS_RESTRICTED_ABIS="3.* *-jython *-pypy-*"

PYTHON_COMPAT=( python2_{6,7} python3_{2,3,4} )

inherit distutils-r1

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Zope Component Architecture"
HOMEPAGE="http://pypi.python.org/pypi/zope.component"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

REQUIRED_USE="test? ( doc )"

# tries to pull in too-recent version of zope-interface, and doc building fails miserably ...
RESTRICT="test"

# net-zope/namespaces-zope[${PYTHON_USEDEP}]
RDEPEND="
	net-zope/zodb[${PYTHON_USEDEP}]
	net-zope/zope-configuration[${PYTHON_USEDEP}]
	net-zope/zope-event[${PYTHON_USEDEP}]
	net-zope/zope-hookable[${PYTHON_USEDEP}]
	net-zope/zope-i18nmessageid[${PYTHON_USEDEP}]
	>=dev-python/zope-interface-3.8.0[${PYTHON_USEDEP}]
	net-zope/zope-proxy[${PYTHON_USEDEP}]
	net-zope/zope-schema[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		dev-python/repoze-sphinx-autointerface[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
	)
	test? ( net-zope/zope-testing[${PYTHON_USEDEP}] )"
PDEPEND="net-zope/zope-security[${PYTHON_USEDEP}]"

DOCS="CHANGES.rst README.rst"
PYTHON_MODULES="${PN/-//}"

src_compile() {
	distutils-r1_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		python_setup
		PYTHONPATH="${S}/${MY_P}-build-${EPYTHON/./_}/lib" emake html
		popd > /dev/null
	fi
}

src_install() {
	distutils-r1_src_install

	if use doc; then
		dohtml -r docs/_build/html/
	fi
}

python_test() {
	esetup.py test
}
