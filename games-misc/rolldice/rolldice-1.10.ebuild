# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games eutils toolchain-funcs

DESCRIPTION="virtual dice roller"
HOMEPAGE="packages.debian.org/rolldice"
SRC_URI="mirror://debian/pool/main/r/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}.orig"

src_prepare() {
	epatch "${FILESDIR}"/*diff
	sed -i -e "s:/usr/games$:${GAMES_BINDIR}:" Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC) ${CFLAGS} ${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README Changelog CREDITS
}
