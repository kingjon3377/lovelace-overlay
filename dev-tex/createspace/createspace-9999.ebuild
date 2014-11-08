# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 latex-package

DESCRIPTION="LaTeX template for CreateSpace books"
HOMEPAGE="https://github.com/aginiewicz/createspace"
EGIT_REPO_URI="https://github.com/aginiewicz/createspace.git"
SRC_URI=""

LICENSE="ZLIB LPPL-1.3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-texlive/texlive-latexrecommended"

src_unpack() {
	git-r3_src_unpack
}

DOCS=( "README" "${PN}.pdf" )

src_compile() {
	default_src_compile
	dvipdf "${PN}.dvi" "${PN}.pdf"
}
