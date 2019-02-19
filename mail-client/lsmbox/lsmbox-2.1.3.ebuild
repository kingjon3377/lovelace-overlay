# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="List number of total/unread messages for mailboxes"
HOMEPAGE="ftp://ftp.acc.umu.se/mirror/lap/lsmbox/"
SRC_URI="ftp://ftp.acc.umu.se/mirror/lap/lsmbox/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${DEPEND}
	app-arch/xz-utils"

src_compile() {
	default_src_compile CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS BUGS ChangeLog lsmbox.lsm NEWS README THANKS TODO doc/*
}
