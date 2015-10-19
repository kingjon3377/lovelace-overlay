# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI=git://gitorious.org/debian-packages/rolldice.git

inherit games git-2 eutils toolchain-funcs

DESCRIPTION="virtual dice roller"
HOMEPAGE="http://packages.debian.org/rolldice"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch debian/patches/*diff
	sed -i -e "s:/usr/games$:${GAMES_BINDIR}:" Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC) ${CFLAGS} ${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README Changelog CREDITS
}
