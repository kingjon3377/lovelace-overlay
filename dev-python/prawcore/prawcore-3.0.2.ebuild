# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
DISTUTILS_USE_PEP517=flit
inherit distutils-r1 pypi

DESCRIPTION="Low-level communication layer for PRAW 4+."
HOMEPAGE="https://pypi.python.org/pypi/prawcore https://github.com/praw-dev/prawcore"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="test? (
			>=dev-python/betamax-0.8[${PYTHON_USEDEP}]
			!!>=dev-python/betamax-0.9[${PYTHON_USEDEP}]
			!!>=dev-python/pytest-8[${PYTHON_USEDEP}]
			!!>=dev-python/urllib3-2[${PYTHON_USEDEP}]
			dev-python/betamax-matchers[${PYTHON_USEDEP}]
			dev-python/betamax-serializers[${PYTHON_USEDEP}]
			dev-python/mock[${PYTHON_USEDEP}]
			dev-python/testfixtures[${PYTHON_USEDEP}]
		)"
RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"

# Depends (according to pyproject.toml) on versions of libraries that will
# conflict with other packages, if still available in the tree at all.
RESTRICT=test

distutils_enable_tests pytest
