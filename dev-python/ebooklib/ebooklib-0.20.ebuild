# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python E-book library for handling books in EPUB2/EPUB3 format"
HOMEPAGE="https://pypi.org/project/EbookLib/ https://github.com/aerkalov/ebooklib"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

# This file relies on a pytest fixture that I can find no reference to anywhere
# else on the Internet; TODO: file a bug upstream
EPYTEST_IGNORE=( tests/test_ebook.py )
