# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Optical Character Recognition (OCR)"
HOMEPAGE="http://lem.eui.upm.es/ocre.html"
SRC_URI="ftp://lem.eui.upm.es/pub/${PN}/${PN}_v${PV/./_}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/gtk+:2
	app-text/aspell"
RDEPEND="${DEPEND}
	media-gfx/imagemagick"

src_prepare() {
	sed -i -e 's/ cc -MM / $(CC) -MM /' ocre/Makefile || die
}

src_configure() {
	emake -C ocre CC=$(tc-getCC) CFLAGS1="${CFLAGS}" depend
}

src_compile() {
	emake -C ocre CC=$(tc-getCC) CFLAGS1="${CFLAGS}"
}

src_install() {
	emake -C ocre DESTDIR="${D}/usr" install installman
}
