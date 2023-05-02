# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

MY_PN=EbookLib

DESCRIPTION="Python E-book library for handling books in EPUB2/EPUB3 format"
HOMEPAGE="https://pypi.org/project/EbookLib/ https://github.com/aerkalov/ebooklib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
BDEPEND=""

S=${WORKDIR}/${MY_PN}-${PV}
