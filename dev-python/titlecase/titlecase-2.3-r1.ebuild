# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..12} )
# PEP517 mode not tested, but this is now required for Manifest generation of
# any version
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python libary to capitalize Strings per NYT Manual of Style"
HOMEPAGE="https://pypi.org/project/titlecase/ https://github.com/ppannuto/python-titlecase"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( dev-python/regex[${PYTHON_USEDEP}] )"

# Tests require Nose, which is no longer supported
RESTRICT=test
#distutils_enable_tests nose
