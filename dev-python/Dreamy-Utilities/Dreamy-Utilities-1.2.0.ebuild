# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )
PYPI_NO_NORMALIZE=true
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Set of various utilities for Python applications"
HOMEPAGE="https://pypi.org/project/Dreamy-Utilities/ https://github.com/DreamCobbler/dreamy-utilities"
SRC_URI="https://files.pythonhosted.org/packages/source/${PN:0:1}/${PN}/${P/-/%20}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64" # no ~x86 because not present in cloudscraper

RDEPEND="dev-python/Babel[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/cloudscraper[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/termtables[${PYTHON_USEDEP}]
	dev-python/titlecase[${PYTHON_USEDEP}]
	dev-python/tldextract[${PYTHON_USEDEP}]"

S="${WORKDIR}/${P/-/ }"

src_prepare() {
	sed -i -e 's@bs4@beautifulsoup4@' setup.py ${PN/-/_}.egg-info/requires.txt || die
	default
}

# Tests not included in PyPI tarball
#python_test() {
	#cd "${S}/Tests" || die
	#"${PYTHON}" "Interface Test.py" || die
	#"${PYTHON}" "Unit Tests.py" || die
#}
