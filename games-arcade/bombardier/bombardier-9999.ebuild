# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://salsa.debian.org/debian/bombardier"

inherit git-r3 toolchain-funcs

DESCRIPTION="The GNU Bombing utility"
HOMEPAGE="https://packages.debian.org/bombardier"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/ncurses:0"
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
}
