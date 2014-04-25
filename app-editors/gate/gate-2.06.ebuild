# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Text gatherer for Fronttalk"
HOMEPAGE="http://www.unixpapa.com/backtalk/fronttalk/"
SRC_URI="http://www.unixpapa.com/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="app-text/aspell"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/getline/gate_getline/' gate.h line.c main.c spel.c subs.c || \
		die "sed failed"
	epatch "${FILESDIR}/term.c.patch"
	sed -i -e 's/Termcap too big.  %d/Termcap too big.  %ld/' term.c || \
		die "sed failed"
}

src_configure() {
	CC=$(tc-getCC) CFLAGS="-pipe -Os -fno-pie" LD=$(tc-getLD) econf --with-aspell
	sed -i -e 's:/usr/share:${prefix}/share:' Makefile || die "sed failed"
}

src_compile() {
	emake
}

src_install() {
	emake prefix="${D}/usr" install
	dodoc README
}
