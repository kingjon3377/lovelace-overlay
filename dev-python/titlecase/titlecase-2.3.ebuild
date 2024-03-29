# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1 pypi

DESCRIPTION="Python libary to capitalize Strings per NYT Manual of Style"
HOMEPAGE="https://pypi.org/project/titlecase/ https://github.com/ppannuto/python-titlecase"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="test? ( dev-python/regex[${PYTHON_USEDEP}] )"

distutils_enable_tests nose
