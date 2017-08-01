# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )
EGIT_REPO_URI="https://github.com/olivierverdier/pydflatex.git"

inherit git-r3 distutils-r1

DESCRIPTION="LaTeX wrapper and log colorizer"
HOMEPAGE="https://github.com/olivierverdier/pydflatex"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/python-termstyle[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
