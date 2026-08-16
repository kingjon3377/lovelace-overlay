# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..14} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="Python Reddit API Wrapper"
HOMEPAGE="https://pypi.org/project/praw/ https://github.com/praw-dev/praw"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/websocket-client[${PYTHON_USEDEP}]
	>=dev-python/prawcore-4.0.0[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/update_checker[${PYTHON_USEDEP}]"
DEPEND="test? (
			${RDEPEND}
			dev-python/vcrpy[${PYTHON_USEDEP}]
			dev-python/coverage[${PYTHON_USEDEP}]
			dev-python/requests[${PYTHON_USEDEP}]
		)"

# Doesn't detect tests; probably need to build from GH tarball instead
#RESTRICT=test
IUSE="doc"

distutils_enable_tests pytest
