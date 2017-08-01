# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="git://git.debian.org/collab-maint/bombardier.git"

inherit games git-r3 toolchain-funcs

DESCRIPTION="The GNU Bombing utility"
HOMEPAGE="http://packages.debian.org/bombardier"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/ncurses:0"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's:/usr/games:/usr/games/bin:' Makefile || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="-lncurses ${LDFLAGS}" all
}

src_install() {
	emake DESTDIR="${D}" install
}
