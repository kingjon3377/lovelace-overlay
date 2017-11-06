# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EHG_REPO_URI="https://alioth.debian.org/anonscm/hg/latrine/"
inherit toolchain-funcs mercurial autotools

DESCRIPTION="curses-based LAnguage TRaINEr"
HOMEPAGE="https://alioth.debian.org/projects/latrine/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sys-libs/ncurses:0[unicode]
	dev-db/sqlite:3"
DEPEND="${RDEPEND}
	sys-devel/autoconf-archive"

src_prepare() {
	cd "${S}"/src
	sed -i -e 's:date -f released:date:' configure.ac
	sed -i -e 's:test -d CVS:test -d .hg:' Makefile.in
	eautoreconf
	ln -s /usr/share/automake-${_LATEST_AUTOMAKE}/install-sh .
}

src_configure() {
	cd "${S}"/src && CC=$(tc-getCXX) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" econf
}

src_compile() {
	emake -C "${S}/src" CC=$(tc-getCXX) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" DEB_BUILD_GNU_TYPE="" all mo
}

src_install() {
	emake -C "${S}/src" DESTDIR="${D}" install DEB_BUILD_GNU_TYPE=""
	dodoc CHANGES README TODO
	insinto /usr/share/${PN}/keymap
	doins keymap/*
}
