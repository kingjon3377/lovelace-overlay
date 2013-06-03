# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="audio collections of words (SWAC) explorer"
HOMEPAGE="http://shtooka.net/"
SRC_URI="http://shtooka.net/soft/swac-tools/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-db/sqlite:3
	dev-cpp/gtkmm:2.4
	dev-cpp/gconfmm
	media-libs/gstreamer:0.10"
RDEPEND="media-sound/swac-get
	${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/*patch
}

src_configure() {
	CC=$(tc-getCC) CFLAGS="${CFLAGS}" econf
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README THANKS NEWS
}
