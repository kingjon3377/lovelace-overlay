# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="lemmatisation of latin text"
#HOMEPAGE="http://www.collatinus.org"
HOMEPAGE="https://github.com/Carreau/Collatinus https://github.com/biblissima/collatinus"
SRC_URI="mirror://debian/pool/main/c/${PN}/${P/-/_}.orig.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#DEPEND="dev-qt/qt-creator
RDEPEND="dev-qt/qtcore:5
	dev-libs/quazip
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtnetwork:5
	x11-libs/libdrm
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/qtchooser
	app-arch/xz-utils
	media-gfx/inkscape
	dev-tex/tex4ht
	virtual/latex-base
	dev-texlive/texlive-latexextra
	dev-texlive/texlive-fontsrecommended"

DOCS=( README.md )

src_prepare() {
	default
	sed -i -e 's@quazip5/quazip.h@quazip/quazip.h@' \
		-e 's@quazip5/quazipfile.h@quazip/quazipfile.h@' src/mainwindow.cpp || die
	sed -i -e 's@-lquazip5@-lquazip1-qt5@' ${PN}.pro || die
	qz_ver="$(best_version dev-libs/quazip)"
	qz_ver="${qz_ver##dev-libs/quazip-}"
	eqmake5 ${PN}.pro "INCLUDEPATH+=/usr/include/QuaZip-Qt5-${qz_ver}"
}

src_compile() {
	default
	for file in *.ts; do
		lrelease $file
	done
}

src_install() {
	dobin "bin/${PN}"
	insinto "/usr/share/${PN}"
	doins -r bin/data/*
	doins "${PN}"_*.qm
	doman "${FILESDIR}/${PN}.1"
	newdoc "${FILESDIR}/doc-en.html" ${PN}.html
	dodoc doc-usr/*
}

pkg_postinst() {
	einfo "The Debian package for collatinus depends on app-text/djview; you may wish to install it."
	einfo
	ewarn "Portage falsely identifies data files installed by this package as Libtool-archive build"
	ewarn "scripts, and tries to \"fix\" them; this may possibly have corrupted the data files."
}
