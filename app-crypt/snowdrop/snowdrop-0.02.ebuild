# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Watermarking for text files and C code"
HOMEPAGE="http://lcamtuf.coredump.cx/"
SRC_URI="http://lcamtuf.coredump.cx/soft/${PN}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
	emake -j1 CC=$(tc-getCC) CFLAGS="${CFLAGS}" all
}

src_install() {
	dobin sd-*
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins synonyms
	dodoc ChangeLog README TODO
}
