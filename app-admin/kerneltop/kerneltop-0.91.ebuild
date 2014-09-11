# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="shows linux kernel function usage in a style like top"
HOMEPAGE="http://www.infradead.org/~rdunlap/src"
SRC_URI="http://www.infradead.org/~rdunlap/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/*.patch
	gunzip ${PN}.1.gz
}

src_compile() {
	emake CC=$(tc-getCC) "CCFLAGS=${CFLAGS}" DEBUG=y all
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc "${FILESDIR}/README.Debian"
}
