# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Lock file lister"
HOMEPAGE="ftp://vic.cc.purdue.edu/pub/tools/unix/lslk/"
SRC_URI="mirror://debian/pool/main/l/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

#PROPERTIES="interactive"

S="${WORKDIR}/${P}.orig"

src_prepare() {
	epatch "${FILESDIR}/savelock-return-codes.patch"
}

src_configure() {
	./Configure -n linux || die "configuring failed"
	epatch "${FILESDIR}/makefile.patch"
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin lslk
	doman lslk.8
	dodoc CHANGELOG README
}
