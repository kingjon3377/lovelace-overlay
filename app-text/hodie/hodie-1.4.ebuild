# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="prints the date in latin"
HOMEPAGE="http://hodie.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/makefile.patch"
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS} ${LDFLAGS}"
}

src_install() {
	dodir /usr/bin /usr/share/doc/${P} /usr/share/man/man1
	emake DESTDIR="${D}" install
	dodoc BUGS CHANGELOG CREDITS DISTRIBUTORS hodie.spec README TODO
}
