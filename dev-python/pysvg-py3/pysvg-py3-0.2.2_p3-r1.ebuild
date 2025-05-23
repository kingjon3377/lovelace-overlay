# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python SVG document creation library"
HOMEPAGE="
	https://github.com/alorence/pysvg-py3/
	https://pypi.org/project/pysvg-py3/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
