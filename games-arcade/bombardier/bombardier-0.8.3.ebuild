# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games toolchain-funcs

NMU_VER=nmu1

DESCRIPTION="The GNU Bombing utility"
HOMEPAGE="http://packages.debian.org/bombardier"
SRC_URI="mirror://debian/pool/main/b/bombardier/${P/-/_}+${NMU_VER}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}+${NMU_VER}"

src_prepare() {
	sed -i -e "s:/var/games:${GAMES_STATEDIR}:" hof.c || die "sed failed"
	sed -i -e 's:/usr/games:/usr/games/bin:' Makefile || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="-lncurses ${LDFLAGS}" all
}

src_install() {
	emake DESTDIR="${D}" install
	dodir "${GAMES_STATEDIR}/${PN}"
	touch "${D}/${GAMES_STATEDIR}/${PN}/bdscore"
	fowners ${GAMES_USER}:${GAMES_GROUP} "/${GAMES_STATEDIR}/${PN}/bdscore"
	fperms 0664 "/${GAMES_STATEDIR}/${PN}/bdscore"
}
