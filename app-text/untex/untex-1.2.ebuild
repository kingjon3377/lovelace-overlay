# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils toolchain-funcs

MY_P="${PN}_${PV}"
DEB_PL="10"

DESCRIPTION="Converts (la)tex files to text"
HOMEPAGE="http://www.ctan.org/pkg/untex"
SRC_URI="http://www.ctan.org/tex-archive/support/untex/untex-1.2.tar.gz"
#	mirror://debian/pool/main/u/untex/${MY_P}-${DEB_PL}.diff.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/*.patch
	sed -i -e 's:^BINDIR=.*:BINDIR=$(DESTDIR)/usr/bin:' \
		-e 's:^MANDIR=.*:MANDIR=$(DESTDIR)/usr/share/man/man$(MANEXT):' \
		-e '/^CFLAGS=.*/d' Makefile || die
}

src_compile() {
#	$(tc-getCC) untex.c -o ${PN} ${CFLAGS} -lresolv -lm || die "Compile failed"
	emake ${PN}
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	emake DESTDIR="${D}" install install.man
}
