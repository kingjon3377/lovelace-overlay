# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="C library and tools for handling Kindle/MOBI ebooks"
HOMEPAGE="https://github.com/bfabiszewski/libmobi"
SRC_URI="https://github.com/bfabiszewski/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/zlib:=
	dev-libs/libxml2:2"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_test() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" test
}

DOCS=( README.md ChangeLog NEWS AUTHORS )

src_install() {
	default
	find "${ED}/usr" -name \*.la -exec rm {} +
}
