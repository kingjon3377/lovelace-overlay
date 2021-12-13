# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_TEST="do"

inherit texlive-common perl-module

DESCRIPTION="LaTeX to XML converter in perl"
HOMEPAGE="https://github.com/brucemiller/LaTeXML https://dlmf.nist.gov/LaTeXML/"
SRC_URI="https://dlmf.nist.gov/${PN}/releases/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="virtual/imagemagick-tools[perl]
	dev-perl/Archive-Zip
	virtual/perl-DB_File
	dev-perl/File-Which
	virtual/perl-Getopt-Long
	dev-perl/Image-Size
	dev-perl/IO-String
	dev-perl/JSON-XS
	dev-perl/libwww-perl
	dev-perl/Pod-Parser
	dev-perl/Text-Unidecode
	virtual/perl-Time-HiRes
	dev-perl/URI
	dev-perl/XML-LibXML
	dev-perl/XML-LibXSLT
	dev-perl/Parse-RecDescent
	dev-perl/UUID-Tiny
	dev-texlive/texlive-latex"
DEPEND="${RDEPEND}"

# Fails several tests on my machine, TODO: report upstream
RESTRICT=test

pkg_setup() {
	myconf=(
		TEXMF="$TEXMF_PATH"
	)
}
