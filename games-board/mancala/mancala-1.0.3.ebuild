# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

DESCRIPTION="Implementation of the simple board game called Mancala"
HOMEPAGE="http://shh.thathost.com/pub-unix/#Mancala"
SRC_URI="http://shh.thathost.com/pub-unix/files/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/libX11
	x11-libs/xforms"
RDEPEND="${DEPEND}"

src_prepare() {
	cp "${FILESDIR}/mancala-text" .
	sed -i -e "s/REPLACEME/${PF}/" \
		-e "s/GAMESDIR/${GAMES_BINDIR}/" mancala-text || die
}

src_compile() {
	emake CC=$(tc-getCC) XLIBDIR= OPTIM="${CFLAGS}" LDOPT="-L. ${LDFLAGS}"
}

src_install() {
	dogamesbin mancala xmancala mancala-text
	dodoc README RULES mancala-1.0.1.lsm NEWS ChangeLog
	doman "${FILESDIR}/mancala.6"
}
