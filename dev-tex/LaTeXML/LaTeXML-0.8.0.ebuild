# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit texlive-common perl-module

DESCRIPTION="LaTeX to XML converter in perl"
HOMEPAGE="http://dlmf.nist.gov/LaTeXML/"
SRC_URI="http://dlmf.nist.gov/${PN}/releases/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-gfx/imagemagick[perl]
	dev-perl/XML-LibXML
	dev-perl/XML-LibXSLT
	dev-perl/Parse-RecDescent
	dev-perl/UUID-Tiny"
DEPEND="${RDEPEND}"

pkg_setup() {
	myconf=(
		TEXMF="$TEXMF_PATH"
	)
}
