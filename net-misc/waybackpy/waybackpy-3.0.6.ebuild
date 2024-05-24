# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0..3} )
DISTUTILS_USE_PEP517=setuptools

inherit pypi distutils-r1

DESCRIPTION="Wayback Machine API interface & a command-line tool"
HOMEPAGE="https://pypi.org/project/waybackpy/ https://github.com/akamhy/waybackpy"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}/${P}-test_exception.patch"
	"${FILESDIR}/${P}-rndstr.patch"
	"${FILESDIR}/${P}-mark_flaky_tests.patch"
)

src_prepare() {
	sed -i -e '/--cov/d' setup.cfg || die
	sed -i -e 's@\(self.api_call_time_gap: int =\) 5$@\1 8@' \
		waybackpy/availability_api.py || die
	default
}

python_install() {
	distutils-r1_python_install
	rm -r "${ED}/$(python_get_sitedir)/tests"
}
