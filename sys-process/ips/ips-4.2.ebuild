# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Intelligent ps"
HOMEPAGE="http://www.tip.net.au/~dbell/"
SRC_URI="http://members.tip.net.au/~dbell/programs/${P}.tgz"

LICENSE="ips"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/libX11
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	dobin ips
	newman ips.man ips.1
	dodoc README
}
