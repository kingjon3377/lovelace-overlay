# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4,5,6} ) # python3_7

inherit distutils-r1

DESCRIPTION="A preprocessor for Markdown"
HOMEPAGE="https://github.com/jreese/markdown-pp"
SRC_URI="https://github.com/jreese/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-python/watchdog[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/flake8[${PYTHON_USEDEP}] )"

src_prepare() {
	sed -i -e 's/python/$(PYTHON)/g' -e 's/^test: lint/test:/' makefile || die
	default
}

python_test() {
	# We don't use 'emake test' because it primarily tests the markdown-pp script,
	# which isn't created yet, and I can't figure out how to make the makefile
	# invoke the Python code it is a wrapper around
	emake lint
	"${PYTHON}" test/test.py
}

DOCS=( readme.mdpp readme.md )
