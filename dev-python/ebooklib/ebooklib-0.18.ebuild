# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
PYPI_PN=EbookLib
PYPI_NO_NORMALIZE=true
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

MY_PN=EbookLib

DESCRIPTION="Python E-book library for handling books in EPUB2/EPUB3 format"
HOMEPAGE="https://pypi.org/project/EbookLib/ https://github.com/aerkalov/ebooklib"

S=${WORKDIR}/${MY_PN}-${PV}
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
