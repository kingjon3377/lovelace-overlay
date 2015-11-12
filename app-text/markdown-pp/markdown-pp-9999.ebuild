# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# Its setup.py claims it's Python 3 compatible, but it appears not to be.
# PYTHON_COMPAT=( python2_7 python3_{2,3} )
PYTHON_COMPAT=( python2_7 )

inherit git-r3 distutils-r1

DESCRIPTION="A preprocessor for Markdown"
HOMEPAGE="https://github.com/jreese/markdown-pp"
SRC_URI=""

EGIT_REPO_URI="https://github.com/jreese/markdown-pp.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#DEPEND=""
#RDEPEND="${DEPEND}"

python_test() {
	"${PYTHON}" ${PN}.py readme.mdpp readme.pp
}

DOCS=( readme.mdpp readme.md )
