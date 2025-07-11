# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="python module that will check for package updates"
HOMEPAGE="https://pypi.org/project/update-checker/ https://github.com/bboe/update_checker"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="test? ( ${RDEPEND} )"

distutils_enable_tests pytest
