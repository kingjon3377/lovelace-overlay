# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit texlive-common perl-module

DESCRIPTION="LaTeX to XML converter in perl"
HOMEPAGE="https://dlmf.nist.gov/LaTeXML/"
SRC_URI="https://dlmf.nist.gov/${PN}/releases/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="|| ( media-gfx/imagemagick[perl] media-gfx/graphicsmagick[perl] )
	dev-perl/XML-LibXML
	dev-perl/XML-LibXSLT
	dev-perl/Parse-RecDescent
	dev-perl/UUID-Tiny
	virtual/perl-DB_File
	dev-perl/Image-Size"
DEPEND="${RDEPEND}"

# A few tests fail, TODO: report upstream
RESTRICT=test

pkg_setup() {
	myconf=(
		TEXMF="$TEXMF_PATH"
	)
}

src_test() {
	emake test
}

src_install() {
	default
	dodoc manual.pdf
}
