# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

PYTHON_REQ_USE="ncurses"

PYPI_PN=${PN}-reader
PYPI_NO_NORMALIZE=true
# Building in PEP517 mode is not tested, but manifest generation fails without
# this
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="CLI EPUB reader"
HOMEPAGE="https://github.com/wustho/epy https://pypi.org/project/epy-reader/"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}-reader" "${PV}")"

S="${WORKDIR}/${PN}-reader-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+mobi"

RDEPEND="mobi? ( dev-python/mobi[${PYTHON_USEDEP}] )"
