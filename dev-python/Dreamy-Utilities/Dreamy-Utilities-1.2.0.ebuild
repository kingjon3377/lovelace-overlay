# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Set of various utilities for Python applications"
HOMEPAGE="https://pypi.org/project/Dreamy-Utilities/ https://github.com/DreamCobbler/dreamy-utilities"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P/-/%20}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64" # no ~x86 because not present in cloudscraper

DEPEND=""
RDEPEND="dev-python/Babel[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/cloudscraper[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/termtables[${PYTHON_USEDEP}]
	dev-python/titlecase[${PYTHON_USEDEP}]
	dev-python/tldextract[${PYTHON_USEDEP}]"
BDEPEND=""

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
