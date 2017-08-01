# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Yet Another BASIC interpreter"
HOMEPAGE="http://yabasic.basicprogramming.org/"
SRC_URI="http://yabasic.basicprogramming.org/files/Yabasic-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-libs/ncurses:0
	x11-libs/libX11
	x11-libs/libICE"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/y/Y}"

src_compile() {
	emake CC=$(tc-getCC) CCFLAGS="${CFLAGS} -DSYSTEM_UNIX"
}

src_install() {
	dobin yabasic
}
