# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Intelligent ps"
HOMEPAGE="https://www.tip.net.au/~dbell/"
SRC_URI="https://members.tip.net.au/~dbell/programs/${P}.tgz"

LICENSE="ips"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="x11-libs/libX11
	sys-libs/ncurses:0"
RDEPEND="${DEPEND}"

src_prepare() {
	if has_version 'sys-libs/ncurses:0[tinfo]';then
		sed -i -e 's@-lcurses @&-ltinfo @' Makefile || die
	fi
	default
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	dobin ips
	newman ips.man ips.1
	dodoc README
}
