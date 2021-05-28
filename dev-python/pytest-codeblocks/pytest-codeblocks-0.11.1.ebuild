# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
DISTUTILS_USE_SETUPTOOLS=pyproject.toml
inherit distutils-r1

DESCRIPTION="pytest plugin for testing code blocks in READMEs"
HOMEPAGE="https://pypi.org/project/pytest-codeblocks/ https://github.com/nschloe/pytest-codeblocks"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"

RDEPEND="${DEPEND}"
DEPEND="test? ( >=dev-python/pytest-6[${PYTHON_USEDEP}] )"
BDEPEND=""

distutils_enable_tests pytest

python_test() {
	distutils_install_for_testing
	epytest -p pytester
}
