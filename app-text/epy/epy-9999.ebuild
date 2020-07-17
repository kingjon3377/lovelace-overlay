# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

PYTHON_REQ_USE="ncurses"

inherit distutils-r1 git-r3

DESCRIPTION="CLI EPUB reader"
HOMEPAGE="https://github.com/wustho/epy"
EGIT_REPO_URI="https://github.com/wustho/epy.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

