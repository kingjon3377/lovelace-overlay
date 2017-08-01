# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5"

PYTHON_COMPAT=( python2_{6,7} python3_{2,3} )

inherit distutils-r1

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Pluggable object copying mechanism"
HOMEPAGE="http://pypi.python.org/pypi/zope.copy"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

# net-zope/namespaces-zope[zope]
RDEPEND="
	dev-python/zope-interface[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		dev-python/repoze-sphinx-autointerface[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
	)
	test? ( net-zope/zope-location[${PYTHON_USEDEP}] )"

DOCS="CHANGES.txt"
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
	esetup.py test
}

src_install() {
	distutils-r1_src_install

	if use doc; then
		dohtml -r docs/_build/html/
	fi
}
