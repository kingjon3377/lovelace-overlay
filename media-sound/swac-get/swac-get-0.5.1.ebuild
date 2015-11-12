# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="audio collections of words (SWAC) manager"
HOMEPAGE="http://shtooka.net/"
SRC_URI="http://shtooka.net/soft/swac-tools/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-db/sqlite:3
	dev-libs/libxml2"
RDEPEND="${DEPEND}"

src_prepare() {
	cd "${WORKDIR}" && epatch "${FILESDIR}/swac-get_0.3-2.1.diff"
	cd "${S}" && epatch "${FILESDIR}"/*patch
}

src_configure() {
	CC=$(tc-getCC) CFLAGS="${CFLAGS}" econf
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README THANKS TODO NEWS
}
