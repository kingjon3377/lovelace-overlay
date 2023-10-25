# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..12} )

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

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=( 01_7dd4e50530e3a4a3b9f2d5fe4ace0ef5aa9b8199.patch  02_8bae47bd510ff034edb5524f5f8ddcb3e6108dcf.patch )

src_install() {
	python_foreach_impl python_doscript "${PN}"
	dodoc README.md
}
