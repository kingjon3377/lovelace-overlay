# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_SETUPTOOLS=pyproject.toml
inherit distutils-r1

DESCRIPTION="Pretty tables in the terminal"
HOMEPAGE="https://pypi.org/project/termtables/ https://github.com/nschloe/termtables"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

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
	distutils_install_for_testing
	epytest --codeblocks
}
