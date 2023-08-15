# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="gzip recovery toolkit"
HOMEPAGE="https://www.urbanophile.com/arenn/coding/gzrt/gzrt.html"
SRC_URI="https://www.urbanophile.com/arenn/coding/gzrt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e 's:\(^CFLAGS.*$\):\1 -lz:' Makefile || die "sed failed"
	default
}

src_compile() {
	emake
}

src_install() {
	dobin gzrecover
	dodoc ChangeLog README
	doman gzrecover.1
}
