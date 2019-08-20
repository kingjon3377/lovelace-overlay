# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Peter's Tetris"
HOMEPAGE="https://packages.debian.org/src:petris"
SRC_URI="mirror://debian/pool/main/p/petris/${PN}_${PV}.orig.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-libs/ncurses:0
	dev-libs/boost"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/petris_1.0.1-8.diff" )

src_prepare() {
	default
	sed -i -e 's:gcc:$(CC):' Makefile || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LIBS="-lncurses ${LDFLAGS}"
}

src_install() {
	dobin petris
	doman petris.6
	dodoc CHANGELOG README
	dodir /var/games
	touch "${D}/var/games/petris.scores"
	fowners "games:games" /var/games/petris.scores
	fperms 0664 /var/games/petris.scores
}
