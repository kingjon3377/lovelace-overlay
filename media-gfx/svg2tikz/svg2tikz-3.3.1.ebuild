# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_SINGLE_IMPL=yes
DISTUTILS_USE_PEP517=poetry

inherit distutils-r1

DESCRIPTION="SVG to PGF/TikZ converter"
HOMEPAGE="https://github.com/xyz2tex/svg2tikz"
SRC_URI="https://github.com/xyz2tex/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEPEND="$(python_gen_cond_dep 'dev-python/lxml[${PYTHON_USEDEP}]')"
# FIXME: BDEPEND instead of DEPEND?
DEPEND="${COMMON_DEPEND}
	$(python_gen_cond_dep 'dev-python/sphinx-argparse[${PYTHON_USEDEP}]
		dev-python/furo[${PYTHON_USEDEP}]')"
RDEPEND="${COMMON_DEPEND}
	>=media-gfx/inkscape-1.4[${PYTHON_SINGLE_USEDEP}]"

# FIXME: Tests depend on 'inkex', part of media-gfx/inkscape but not on standard Python package path
RESTRICT="test"

src_install() {
	distutils-r1_src_install
	dodoc -r docs/*.rst docs/conf.py docs/img
	dodir /usr/share/doc/${PF}/html
	emake -C docs html BUILDDIR="${D}/usr/share/doc/${PF}/html"
}
