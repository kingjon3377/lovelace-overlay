# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs

MY_P="${PN}_${PV}"
DEB_PL="10"

DESCRIPTION="Converts (la)tex files to text"
HOMEPAGE="http://packages.debian.org/stable/tex/untex"
SRC_URI="mirror://debian/pool/main/u/untex/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/u/untex/${MY_P}-${DEB_PL}.diff.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

S="${S}.orig"

src_prepare() {
	epatch "${WORKDIR}/${MY_P}-${DEB_PL}.diff"
}

src_compile() {
	$(tc-getCC) untex.c -o ${PN} ${CFLAGS} -lresolv -lm || die "Compile failed"
}

src_install() {
	dobin untex
}
