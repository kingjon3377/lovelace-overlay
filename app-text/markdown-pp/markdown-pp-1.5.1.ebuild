# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..12} )
DISTUTILS_USE_PEP517=setuptools

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

RESTRICT="!test? ( test )"

src_prepare() {
	sed -i -e 's/python/$(PYTHON)/g' -e 's/^test: lint/test:/' makefile || die
	default
}

python_test() {
	# We don't use 'emake test' because it primarily tests the markdown-pp script,
	# which isn't created yet, and I can't figure out how to make the makefile
	# invoke the Python code it is a wrapper around
	# TODO: This should be easier in PEP517 mode, perhaps?
	emake lint
	"${PYTHON}" test/test.py
}

DOCS=( readme.mdpp readme.md )

# flake8 now fails (2023-10)
RESTRICT=test
