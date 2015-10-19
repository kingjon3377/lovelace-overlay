# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games toolchain-funcs

DESCRIPTION="Peter's Tetris"
HOMEPAGE="http://packages.debian.org/src:petris"
SRC_URI="mirror://debian/pool/main/p/petris/${PN}_${PV}.orig.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-libs/ncurses
	dev-libs/boost"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/petris_1.0.1-8.diff"
	sed -i -e 's:gcc:$(CC):' Makefile || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LIBS="-lncurses ${LDFLAGS}"
}

src_install() {
	dogamesbin petris
	doman petris.6
	dodoc CHANGELOG README
	# TODO: replace /var/games constant in config.h and here with the equivalent
	# variable from games.eclass
	dodir /var/games
	touch "${D}/var/games/petris.scores"
	fowners "${GAMES_USER}:${GAMES_GROUP}" /var/games/petris.scores
	fperms 0664 /var/games/petris.scores
}
