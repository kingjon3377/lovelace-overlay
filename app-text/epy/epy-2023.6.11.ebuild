# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..12} )

DISTUTILS_USE_PEP517=poetry
PYTHON_REQ_USE="ncurses"
PYPI_PN="${PN}-reader"

inherit distutils-r1 pypi

DESCRIPTION="CLI EPUB reader"
HOMEPAGE="https://github.com/wustho/epy https://pypi.org/project/epy-reader/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+mobi"

RDEPEND="mobi? ( dev-python/mobi[${PYTHON_USEDEP}] )"

#distutils_enable_tests pytest # Tests not included in tarball
