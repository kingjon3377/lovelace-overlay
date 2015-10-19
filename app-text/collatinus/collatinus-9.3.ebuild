# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils qt4-r2

DESCRIPTION="lemmatisation of latin text"
HOMEPAGE="http://www.collatinus.org"
SRC_URI="mirror://debian/pool/main/c/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

#DEPEND="dev-qt/qt-creator
DEPEND="
	dev-qt/qt3support:4
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	media-gfx/inkscape
	dev-tex/tex4ht
	virtual/latex-base
	dev-texlive/texlive-latexextra
	dev-texlive/texlive-fontsrecommended"
RDEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4"

src_unpack() {
	default_src_unpack
	cd "${WORKDIR}" && mv -i ${P}.orig ${P}
}

src_prepare() {
	epatch "${FILESDIR}"/*patch
}

src_configure() {
	qt4-r2_src_configure
	inkscape --export-png=images/alpha.png "${FILESDIR}/alpha.svg" || die "creating image failed"
}

src_compile() {
	qt4-r2_src_compile
}

src_install() {
	dobin ${PN}
	insinto /usr/share/${PN}
	doins lemmata.* expressions.fr config lucretia.txt txt/*txt txt/cic-familiares
	doman "${FILESDIR}/${PN}.1"
	dohtml doc/*html doc/*css
	dodoc AGENDA BOGUES collatinus.tex
}
