# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="List number of total/unread messages for mailboxes"
HOMEPAGE="ftp://ftp.acc.umu.se/mirror/lap/lsmbox/"
SRC_URI="ftp://ftp.acc.umu.se/mirror/lap/lsmbox/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	default_src_compile CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

# TODO: convert to DOCS=() default_src_install
src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS BUGS lsmbox.lsm NEWS README THANKS TODO doc/*
}
