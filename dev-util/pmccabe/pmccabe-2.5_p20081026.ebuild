# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="McCabe-style function complexity and line counting for C and C++"
HOMEPAGE="http://www.parisc-linux.org/~bame/pmccabe/"
SRC_URI="http://cvs.parisc-linux.org/download/${P/_p/-CVS}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i \
		-e 's|$(PROGS) test|$(PROGS)|' \
		-e 's|-o root -g root||' \
		Makefile || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog TODO
}
