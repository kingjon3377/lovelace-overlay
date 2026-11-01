# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python E-book library for handling books in EPUB2/EPUB3 format"
HOMEPAGE="https://pypi.org/project/EbookLib/ https://github.com/aerkalov/ebooklib"
epub_sha=b162ab0ab4aec8f86499a87705d20baab1f6d027
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV}")
	https://github.com/aerkalov/${PN}/raw/${epub_sha}/tests/resources/test01.epub -> ${P}-test01.epub"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

src_unpack() {
	default
	mkdir "${S}/tests/resources"
	cp "${DISTDIR}/${P}-test01.epub" "${S}/tests/resources/test01.epub"
}

# This file relies on a pytest fixture that I can find no reference to anywhere
# else on the Internet; TODO: file a bug upstream
EPYTEST_IGNORE=( tests/test_ebook.py )
