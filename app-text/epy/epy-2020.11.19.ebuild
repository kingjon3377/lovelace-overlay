# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

PYTHON_REQ_USE="ncurses"

inherit distutils-r1 

DESCRIPTION="CLI EPUB reader"
HOMEPAGE="https://github.com/wustho/epy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}-reader/${PN}-reader-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${PN}-reader-${PV}"
