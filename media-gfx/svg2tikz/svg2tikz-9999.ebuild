# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/kjellmf/svg2tikz.git"

PYTHON_COMPAT=( python{2_5,2_6,2_7} )
inherit git-r3 distutils-r1

DESCRIPTION="SVG to PGF/TikZ converter"
HOMEPAGE="https://github.com/kjellmf/svg2tikz.git"
SRC_URI=""

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="dev-python/lxml"
DEPEND="${COMMON_DEPEND}
	dev-python/sphinx"
RDEPEND="${COMMON_DEPEND}
	media-gfx/inkscape"

# FIXME: Run tests

src_install() {
	distutils-r1_src_install
	dodoc -r docs/*.rst docs/conf.py docs/img
	dodir /usr/share/doc/${PF}/html
	emake -C docs html BUILDDIR="${D}/usr/share/doc/${PF}/html"
}
