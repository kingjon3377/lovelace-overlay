# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION="Low-level communication layer for PRAW 4+."
HOMEPAGE="https://pypi.python.org/pypi/prawcore https://github.com/praw-dev/prawcore"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="test? (
			dev-python/betamax[${PYTHON_USEDEP}]
			dev-python/betamax-matchers[${PYTHON_USEDEP}]
			dev-python/betamax-serializers[${PYTHON_USEDEP}]
			dev-python/mock[${PYTHON_USEDEP}]
			dev-python/testfixtures[${PYTHON_USEDEP}]
		)"
RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND=""

distutils_enable_tests pytest
