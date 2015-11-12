# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

PYTHON_COMPAT=( python2_{6,7} python3_{2,3,4} )

inherit distutils-r1

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Zope hookable"
HOMEPAGE="http://pypi.python.org/pypi/zope.hookable"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

#RDEPEND="net-zope/namespaces-zope[zope,${PYTHON_USEDEP}]"
RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

DISTUTILS_GLOBAL_OPTIONS=("*-jython --without-Cwrapper")
DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN/-//}"

src_compile() {
	distutils-r1_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		python_setup
		PYTHONPATH="$(ls -d ../../${MY_P}-build-${EPYTHON/\./_}/lib*)" emake html
		popd > /dev/null
	fi
}

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}

src_install() {
	distutils-r1_src_install

	if use doc; then
		dohtml -r docs/_build/html/
	fi
}
