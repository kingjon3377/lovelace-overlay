# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1 pypi

DESCRIPTION="Python implementation of kakasi - kana kanji simple inversion library"
HOMEPAGE="https://pypi.org/project/pykakasi/ https://github.com/miurahr/pykakasi"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test doc"

RDEPEND="dev-python/jaconv[${PYTHON_USEDEP}]
	dev-python/deprecated[${PYTHON_USEDEP}]"
DEPEND="test? (
			${RDEPEND}
			dev-python/py-cpuinfo[${PYTHON_USEDEP}]
		)
		doc? (
			dev-python/sphinx[${PYTHON_USEDEP}]
			dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
		)"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

RESTRICT="!test? ( test )"

distutils_enable_tests pytest

EPYTEST_DESELECT=( tests/test_pykakasi_advanced.py::test_benchmark )

src_prepare() {
	sed -i -e '22,$d' tests/conftest.py || die
	sed -i -e '/sphinx-py3doc-enhanced-theme/d' setup.cfg src/pykakasi.egg-info/requires.txt || die
	default
}
