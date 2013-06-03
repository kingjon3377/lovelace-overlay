# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils qt4-r2

DESCRIPTION="lemmatisation of latin text"
#HOMEPAGE="http://www.collatinus.org"
HOMEPAGE="http://github.com/Carreau/Collatinus"
SRC_URI="mirror://debian/pool/main/c/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
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
	dev-qt/qtgui"

src_unpack() {
	default_src_unpack
	cd "${WORKDIR}" && mv -i ${P}.orig ${P} || die "renaming dir failed"
}

#src_prepare() {
#	epatch "${FILESDIR}"/collatinus_9.3-4.diff || die "initial patch failed"
#	sed -i -e 's:/usr/share/collatinus/collatinus /usr/bin/collatinus:../share/collatinus/collatinus $(INSTALL_ROOT)/usr/bin/collatinus:' \
#		collatinus.pro || die "sed failed"
#}

src_configure() {
	qt4-r2_src_configure
}

src_compile() {
	die "Compiling felix.cpp uses up all available memory, so as it's vanished from git we'll just wait to upgrade"
	qt4-r2_src_compile
}

src_install() {
	qt4-r2_src_install
#	dobin ${PN}
#	insinto /usr/share/${PN}
##	doins lemmata.* expressions.fr config lucretia.txt txt/*txt txt/cic-familiares
#	doman doc/${PN}.1
#	dohtml doc/*html doc/*css
#	dodoc AGENDA BOGUES collatinus.tex
}
