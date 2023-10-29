# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Pure-Python Japanese character interconverter"
HOMEPAGE="https://pypi.org/project/jaconv/ https://github.com/ikegami-yukino/jaconv"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Tests aren't included in the PyPI tarball
RESTRICT=test
#distutils_enable_tests nose

src_prepare() {
	sed -i -e "s@''@'/usr/share/doc/${PF}'@" setup.py || die
	default
}
