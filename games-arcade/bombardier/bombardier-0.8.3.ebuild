# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

NMU_VER=nmu1

DESCRIPTION="The GNU Bombing utility"
HOMEPAGE="https://packages.debian.org/bombardier"
SRC_URI="mirror://debian/pool/main/b/bombardier/${P/-/_}+${NMU_VER}.tar.gz"

S="${WORKDIR}/${P}+${NMU_VER}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="acct-group/gamestat"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's:/usr/games:/usr/bin:' Makefile || die "sed failed"
	default
}

src_compile() {
	local link_flags
	if has_version 'sys-libs/ncurses[tinfo]'; then
		link_flags="-lncurses -ltinfo"
	else
		link_flags="-lncurses"
	fi
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${link_flags} ${LDFLAGS}" all
}

src_install() {
	emake DESTDIR="${D}" install
	dodir "/var/games/${PN}"
	touch "${D}/var/games/${PN}/bdscore"
	fowners :gamestat "/var/games/${PN}/bdscore"
	fperms 0664 "/var/games/${PN}/bdscore"
}
