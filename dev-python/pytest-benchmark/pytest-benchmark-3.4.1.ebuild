# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="pytest fixture for benchmarking code"
HOMEPAGE="https://pypi.org/project/pytest-benchmark/ https://github.com/ionelmc/pytest-benchmark"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/py-cpuinfo[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/aspectlib[${PYTHON_USEDEP}]"
DEPEND="test? (
			${RDEPEND}
			dev-python/pygal[${PYTHON_USEDEP}]
		)"
BDEPEND=""

distutils_enable_tests pytest

src_prepare() {
	# Don't want to pull in this dependency
	rm tests/test_elasticsearch_storage.py || die
	# Failures, maybe due to fragility in the presence of other pytest plugins than the developers expect?
	rm tests/test_cli.py || die
	default
}

python_test() {
	distutils_install_for_testing
	epytest
}
