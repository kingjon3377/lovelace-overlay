# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="Random identity generator"
HOMEPAGE="http://rig.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/"*patch
}

src_compile() {
	emake CC=$(tc-getCXX) CFLAGS="${CXXFLAGS}" PREFIX=/usr
}

src_install() {
	dodir /usr/bin /usr/share/man/man6
	emake PREFIX="${D}/usr" MANDIR="${D}/usr/share/man" install
}
