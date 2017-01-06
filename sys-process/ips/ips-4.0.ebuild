# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Intelligent ps"
HOMEPAGE="http://www.tip.net.au/~dbell/"
SRC_URI="http://members.tip.net.au/~dbell/programs/${P}.tar.gz"

LICENSE="ips"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="x11-libs/libX11
	sys-libs/ncurses:0"
RDEPEND="${DEPEND}"

src_prepare() {
	if has_version 'sys-libs/ncurses[tinfo]';then
		sed -i -e 's@-lcurses @&-ltinfo @' Makefile || die
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	dobin ips
	newman ips.man ips.1
	dodoc README
}
