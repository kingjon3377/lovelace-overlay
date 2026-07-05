# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..14} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="Low-level communication layer for PRAW 4+."
HOMEPAGE="https://pypi.python.org/pypi/prawcore https://github.com/praw-dev/prawcore"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="test? (
			dev-python/vcrpy[${PYTHON_USEDEP}]
			dev-python/coverage[${PYTHON_USEDEP}]
		)
		doc? (
			dev-python/sphinx-autodoc-typehints[${PYTHON_USEDEP}]
			dev-python/furo[${PYTHON_USEDEP}]
			dev-python/sphinx[${PYTHON_USEDEP}]
		)"
RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"

IUSE="doc"

distutils_enable_tests pytest
