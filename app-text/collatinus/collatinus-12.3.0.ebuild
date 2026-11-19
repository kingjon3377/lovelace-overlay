# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="lemmatisation of latin text"
#HOMEPAGE="http://www.collatinus.org"
HOMEPAGE="https://github.com/Carreau/Collatinus https://github.com/jiang-che/collatinus-qt6"
SRC_URI="https://github.com/jiang-che/${PN}-qt6/releases/download/v${PV}/${PN}-qt6-${PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-qt/qtbase:6=[gui,widgets,network]
	dev-qt/qtsvg:6=
	x11-libs/libdrm
	dev-libs/quazip:0=
	dev-qt/qttools:6=[linguist]
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5"
DEPEND="${RDEPEND}"
BDEPEND=" app-arch/xz-utils
	media-gfx/inkscape
	dev-tex/tex4ht
	virtual/latex-base
	dev-texlive/texlive-latexextra
	dev-texlive/texlive-fontsrecommended"

S="${WORKDIR}/${PN}-qt6-${PV}"

DOCS=( README.md )
