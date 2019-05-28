# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="lemmatisation of latin text"
#HOMEPAGE="http://www.collatinus.org"
HOMEPAGE="https://github.com/Carreau/Collatinus"
SRC_URI="mirror://debian/pool/main/c/${PN}/${P/-/_}.orig.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#DEPEND="dev-qt/qt-creator
RDEPEND="dev-qt/qtcore:5
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

src_unpack() {
	default_src_unpack
	cd "${WORKDIR}" && mv -i ${P}.orig ${P} || die "renaming dir failed"
}

PATCHES=(
	"${FILESDIR}"/${P}-pathToData.patch
	"${FILESDIR}"/${P}-pro.patch
)

DOCS=( README.md )

src_prepare() {
	default
	rm -f bin/data/dicos # unsafe symlink in upstream source
	eqmake5
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
