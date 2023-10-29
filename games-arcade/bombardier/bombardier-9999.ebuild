# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="git://git.debian.org/collab-maint/bombardier.git"

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
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="-lncurses ${LDFLAGS}" all
}

src_install() {
	emake DESTDIR="${D}" install
}
