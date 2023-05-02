# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )

PYTHON_REQ_USE="ncurses"

inherit distutils-r1

DESCRIPTION="CLI EPUB reader"
HOMEPAGE="https://github.com/wustho/epy https://pypi.org/project/epy-reader/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}-reader/${PN}-reader-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+mobi"

RDEPEND="mobi? ( dev-python/mobi[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${PN}-reader-${PV}"
