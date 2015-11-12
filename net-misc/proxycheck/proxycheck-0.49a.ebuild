# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs

DESCRIPTION="checks existence of open proxy"
HOMEPAGE="http://www.corpit.ru/mjt/proxycheck.html"
SRC_URI="http://www.corpit.ru/mjt/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" ./configure || die "configure failed"
}

src_install() {
	dobin proxycheck
	doman proxycheck.1
	dodoc CHANGES
}
