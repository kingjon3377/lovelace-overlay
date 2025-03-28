# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_TEST="do"

if [[ ${PV} == *9999 ]]; then
	inherit texlive-common perl-module git-r3
else
	inherit texlive-common perl-module
fi

DESCRIPTION="LaTeX to XML converter in perl"
HOMEPAGE="https://github.com/brucemiller/LaTeXML https://math.nist.gov/~BMiller/LaTeXML/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/brucemiller/LaTeXML.git"
else
	SRC_URI="https://dlmf.nist.gov/${PN}/releases/${P}.tar.gz"
fi

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

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

pkg_setup() {
	myconf=(
		TEXMF="${TEXMF_PATH:-/usr/share/texmf-site}"
	)
}
