# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs

DESCRIPTION="RPN calculator trying to emulate an HP28S"
HOMEPAGE="http://packages.debian.org/rpncalc"
SRC_URI="mirror://debian/pool/main/r/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-libs/readline:0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README AUTHORS debian/changelog debian/copyright
}
