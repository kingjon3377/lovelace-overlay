# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Find duplicate music files regardless of format and tags"
HOMEPAGE="http://w140.com/audio/"
SRC_URI="http://w140.com/audio/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/perl[gdbm]
	sci-libs/fftw:3.0
	sys-libs/gdbm
	virtual/perl-Digest-MD5"
RDEPEND="${DEPEND}
	media-video/mplayer
	media-libs/plotutils"

src_prepare() {
	sed -i -e "s,^CC =  gcc$,CC = $(tc-getCC)," \
		-e "s,^CFLAGS = -O2 -W -Wall -I/usr/local/include -L/usr/local/lib,CFLAGS = ${CFLAGS}," \
		Makefile || die
}

src_install() {
	dobin "${PN}"
	newbin vector_pairs ${PN}_vector_pairs
	dobin sonic_reducer
	dodoc CHANGES README
	docinto examples
	dodoc optparam cleanup_dups fdmf_bench
}
