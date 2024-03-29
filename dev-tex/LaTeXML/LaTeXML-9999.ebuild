# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit texlive-common perl-module git-r3

DESCRIPTION="LaTeX to XML converter in perl"
HOMEPAGE="https://github.com/brucemiller/LaTeXML https://math.nist.gov/~BMiller/LaTeXML/"
#SRC_URI="http://dlmf.nist.gov/${PN}/releases/${P}.tar.gz"

EGIT_REPO_URI="https://github.com/brucemiller/LaTeXML.git"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="|| ( media-gfx/imagemagick[perl] media-gfx/graphicsmagick[perl] )
	dev-perl/XML-LibXML
	dev-perl/XML-LibXSLT
	dev-perl/Parse-RecDescent
	dev-perl/UUID-Tiny
	dev-perl/IO-String"
DEPEND="${RDEPEND}"

pkg_setup() {
	myconf=(
		TEXMF="$TEXMF_PATH"
	)
}
