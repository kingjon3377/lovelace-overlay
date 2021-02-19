# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} ) # python3_8 blocked by python-termstyle
EGIT_REPO_URI="https://github.com/olivierverdier/pydflatex.git"

inherit git-r3 distutils-r1

DESCRIPTION="LaTeX wrapper and log colorizer"
HOMEPAGE="https://github.com/olivierverdier/pydflatex"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/blessings[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

distutils_enable_tests unittest
