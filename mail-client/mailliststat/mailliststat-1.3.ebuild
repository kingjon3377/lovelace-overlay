# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="Displays statistics about mbox files"
HOMEPAGE="http://www.marki-online.net/MLS/"
SRC_URI="http://www.marki-online.net/MLS/mls-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls"

RDEPEND=""
DEPEND="${RDEPEND}
	nls? ( app-text/po4a )"

S="${WORKDIR}/mls-${PV}"

src_prepare() {
	epatch "${FILESDIR}/mailliststat_1.3-5.diff"
	epatch "${FILESDIR}/*patch"
	sed -i -e 's:(DESTDIR)/man:(DESTDIR)/share/man:' -e 's:gcc -D:$(USER_CC) -D:' Makefile || die "sed failed"
	use nls || sed -i -e 's/all: po4a/all:/' man/Makefile || die "sed failed"
}

src_compile() {
	if use nls; then
		emake USER_CC=$(tc-getCC) CFLAGS="${CFLAGS}"
	else
		emake USER_CC=$(tc-getCC) CFLAGS="${CFLAGS}" ${PN}
		emake -C po USER_CC=$(tc-getCC) CFLAGS="${CFLAGS}"
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc HISTORY.mls.txt README.txt "${FILESDIR}"/README.Debian
	dohtml html/*
	docinto examples
	dodoc examples/*
}
