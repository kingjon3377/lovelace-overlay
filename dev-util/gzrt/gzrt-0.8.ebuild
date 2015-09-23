# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="gzip recovery toolkit"
HOMEPAGE="http://www.urbanophile.com/arenn/coding/gzrt/gzrt.html"
SRC_URI="http://www.urbanophile.com/arenn/coding/gzrt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND=""

src_prepare() {
	sed -i -e 's:\(^CFLAGS.*$\):\1 -lz:' \
		-e 's/	cc /	$(CC) $(CFLAGS) /' Makefile || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	dobin gzrecover
	dodoc ChangeLog README
	doman gzrecover.1
}
