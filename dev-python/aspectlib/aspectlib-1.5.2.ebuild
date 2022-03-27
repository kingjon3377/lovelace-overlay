# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="aspect-oriented programming, monkey-patch and decorators library"
HOMEPAGE="https://pypi.org/project/aspectlib/ https://github.com/ionelmc/python-aspectlib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/fields[${PYTHON_USEDEP}]"
DEPEND="test? (
			${RDEPEND}
			dev-python/mock[${PYTHON_USEDEP}]
			dev-python/six[${PYTHON_USEDEP}]
			www-servers/tornado[${PYTHON_USEDEP}]
		)"
BDEPEND=""

RESTRICT="!test? ( test )"

PATCHES=( "${FILESDIR}/7dccb198dfb426f529b81a28a755f3c02f8b50cb.patch" )

distutils_enable_tests pytest
