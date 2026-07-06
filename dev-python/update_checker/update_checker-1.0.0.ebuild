# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..14} )
DISTUTILS_USE_PEP517=uv-build
inherit distutils-r1 pypi

DESCRIPTION="python module that will check for package updates"
HOMEPAGE="https://pypi.org/project/update-checker/ https://github.com/bboe/update_checker"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Tests seem to be missing from PyPI tarball
RESTRICT=test

distutils_enable_tests pytest
