# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="Python implementation of kakasi - kana kanji simple inversion library"
HOMEPAGE="https://pypi.org/project/pykakasi/ https://github.com/miurahr/pykakasi"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

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
			dev-python/sphinx-py3doc-enhanced-theme[${PYTHON_USEDEP}]
			dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]
		)"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	dev-python/pytest-benchmark[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
