# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="python module that will check for package updates"
HOMEPAGE="https://pypi.org/project/update-checker/ https://github.com/bboe/update_checker"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="test? ( ${RDEPEND} )"
BDEPEND=""

distutils_enable_tests pytest
