# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Pretty tables in the terminal"
HOMEPAGE="https://pypi.org/project/termtables/ https://github.com/nschloe/termtables"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="test? (
		dev-python/pytest-codeblocks[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
	) "
BDEPEND="dev-python/wheel[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_test() {
	epytest --codeblocks
}
