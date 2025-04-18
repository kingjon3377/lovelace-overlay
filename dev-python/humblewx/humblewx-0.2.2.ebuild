# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Library that simplifies creating user interfaces with wxPython"
HOMEPAGE="https://github.com/thetimelineproj/humblewx"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${DEPEND}
	dev-python/wxpython:4.0[${PYTHON_USEDEP}]"
