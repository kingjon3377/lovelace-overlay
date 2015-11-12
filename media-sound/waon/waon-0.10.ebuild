# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="A Wave-to-Notes transcriber"
HOMEPAGE="http://waon.sourceforge.net/"
SRC_URI="mirror://sourceforge/waon/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sci-libs/fftw:3.0
	media-libs/libao
	media-libs/libsndfile
	media-libs/libsamplerate
	dev-libs/glib:2
	x11-libs/gtk+:2
	x11-libs/pango"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/cflags.patch"
}

src_compile() {
	emake CC=$(tc-getCC) USER_CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin waon pv gwaon
	doman waon.1 pv.1 gwaon.1
	dodoc ChangeLog README TIPS TODO
}
