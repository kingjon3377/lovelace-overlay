# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

NMU_VER=nmu1

DESCRIPTION="The GNU Bombing utility"
HOMEPAGE="https://packages.debian.org/bombardier"
SRC_URI="mirror://debian/pool/main/b/bombardier/${P/-/_}+${NMU_VER}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}+${NMU_VER}"

src_prepare() {
	sed -i -e 's:/usr/games:/usr/bin:' Makefile || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="-lncurses ${LDFLAGS}" all
}

src_install() {
	emake DESTDIR="${D}" install
	dodir "/var/games/${PN}"
	touch "${D}/var/games/${PN}/bdscore"
	fowners games:games "/var/games/${PN}/bdscore"
	fperms 0664 "/var/games/${PN}/bdscore"
}
