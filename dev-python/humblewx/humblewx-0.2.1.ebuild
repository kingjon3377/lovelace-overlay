# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Python 3.10 blocked by wxpython
PYTHON_COMPAT=( python3_{8..11} )
inherit distutils-r1

DESCRIPTION="Library that simplifies creating user interfaces with wxPython"
HOMEPAGE="https://github.com/thetimelineproj/humblewx"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/wxpython:4.0[${PYTHON_USEDEP}]"
BDEPEND=""
