# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Zope Configuration Markup Language (ZCML)"
HOMEPAGE="http://pypi.python.org/pypi/zope.configuration"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

# net-zope/namespaces-zope
RDEPEND="
	net-zope/zope-i18nmessageid
	net-zope/zope-interface
	net-zope/zope-schema"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? (
		dev-python/repoze-sphinx-autointerface
		dev-python/sphinx
	)"

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN/-//}"

distutils_src_compile_post_hook() {
	if [[ "$(python_get_version -l --major)" == "3" ]]; then
		# https://bugs.launchpad.net/zope.configuration/+bug/1025390
		2to3-${PYTHON_ABI} -nw --no-diffs build-${PYTHON_ABI}/lib/zope/configuration/{stxdocs.py,tests/conditions.py}
	fi
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		PYTHONPATH="../build-$(PYTHON -f --ABI)/lib" emake html
		popd > /dev/null
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/_build/html/
	fi
}
