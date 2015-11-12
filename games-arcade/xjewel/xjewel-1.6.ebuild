# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games eutils toolchain-funcs

DESCRIPTION="match colors on falling columns of blocks"
HOMEPAGE="http://packages.debian.org/xjewel"
SRC_URI="ftp://ftp.warwick.ac.uk/pub/x11/xjewel-1.6.tar.z"

LICENSE="xjewel"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/xjewel_1.6-24.diff
}

src_compile() {
	emake CC=$(tc-getCC) USERDEFS="-DICON_WINDOW -DLEAVE_PAUSE ${CFLAGS}" LDFLAGS="-lX11 ${LDFLAGS}" -f Makefile.simple
}

src_install() {
	dogamesbin xjewel
	dodir /var/games
	touch "${D}/var/games/${PN}.scores"
	fowners ${GAMES_USER}:${GAMES_GROUP} "/var/games/${PN}.scores"
	fperms 664 "/var/games/${PN}.scores"
	newman xjewel.man ${PN}.6
	dodoc README xjewel.ps xjewel.help
}
