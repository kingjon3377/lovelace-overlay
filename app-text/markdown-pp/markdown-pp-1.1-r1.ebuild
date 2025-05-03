# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Its setup.py claims it's Python 3 compatible, but it appears not to be.
PYTHON_COMPAT=( python3_{8..12} )
# PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A preprocessor for Markdown"
HOMEPAGE="https://github.com/jreese/markdown-pp"
SRC_URI="https://github.com/jreese/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	sed -i -e 's/python/$(PYTHON)/g' -e 's/^test: lint/test:/' makefile || die
	default
}

python_test() {
	emake test
}

DOCS=( readme.mdpp readme.md )
