# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="reachability analyzer for Algebraic System Nets"
HOMEPAGE="http://www.tcs.hut.fi/Software/maria/index.en.html"
SRC_URI="http://www.tcs.hut.fi/Software/maria/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	emake -j 1 -f Makefile.Linux depend
}

src_compile() {
	emake -f Makefile.Linux CC=$(tc-getCC) CXX=$(tc-getCXX) CFLAGS="-ansi ${CFLAGS}"
}

src_install() {
	emake -f Makefile.Linux PREFIX="${D}/usr" \
		EXDIR="${D}/usr/share/doc/${PF}/examples" INFODIR="${D}/usr/share/info" \
		install installman installinfo
}
