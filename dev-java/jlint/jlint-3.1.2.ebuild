# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="A Java Program Checker"
HOMEPAGE="http://jlint.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${P}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

IUSE=""

src_prepare() {
	epatch "${FILESDIR}/${PN}.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" CPP="$(tc-getCXX)" CFLAGS="${CFLAGS}" LDFLAGS="-lz ${LDFLAGS}"
}

src_install() {
	dodir /usr/bin
	emake INSTALL_DIR="${D}/usr/bin" install
	dodoc BUGS CHANGELOG README TODO manual.pdf manual.texi
	dohtml manual.html
}
