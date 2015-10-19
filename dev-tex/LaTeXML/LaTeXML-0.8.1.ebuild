# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit texlive-common perl-module

DESCRIPTION="LaTeX to XML converter in perl"
HOMEPAGE="http://dlmf.nist.gov/LaTeXML/"
SRC_URI="http://dlmf.nist.gov/${PN}/releases/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="|| ( media-gfx/imagemagick[perl] media-gfx/graphicsmagick[perl] )
	dev-perl/XML-LibXML
	dev-perl/XML-LibXSLT
	dev-perl/Parse-RecDescent
	dev-perl/UUID-Tiny"
DEPEND="${RDEPEND}"

# Fails several tests on my machine
RESTRICT=test

pkg_setup() {
	myconf=(
		TEXMF="$TEXMF_PATH"
	)
}

src_test() {
	emake test
}
