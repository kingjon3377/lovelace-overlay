# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit python-r1 git-r3

DESCRIPTION="Python script to diff EPUBs"
HOMEPAGE="https://bencrowder.net/coding/epubdiff/"
EGIT_REPO_URI="https://github.com/bencrowder/epubdiff.git"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="${PYTHON_DEPS}
	dev-python/pyquery[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	python_replicate_script "${PN}"
	dodoc README.md
}
