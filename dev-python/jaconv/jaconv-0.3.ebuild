# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Pure-Python Japanese character interconverter"
HOMEPAGE="https://pypi.org/project/jaconv/ https://github.com/ikegami-yukino/jaconv"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""
BDEPEND=""

# Tests aren't included in the PyPI tarball
RESTRICT=test
#distutils_enable_tests nose

src_prepare() {
	sed -i -e "s@''@'/usr/share/doc/${PF}'@" setup.py || die
	default
}
