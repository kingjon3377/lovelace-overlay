# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# Its setup.py claims it's Python 3 compatible, but it appears not to be.
PYTHON_COMPAT=( python2_7 python3_{2,3,4} )
# PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A preprocessor for Markdown"
HOMEPAGE="https://github.com/jreese/markdown-pp"
SRC_URI="https://github.com/jreese/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#DEPEND=""
#RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/python/$(PYTHON)/g' -e 's/^test: lint/test:/' makefile || die
	default
}

python_test() {
	emake test
}

DOCS=( readme.mdpp readme.md )
