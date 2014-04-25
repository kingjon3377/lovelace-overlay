# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="curses-based LAnguage TRaINEr"
HOMEPAGE="http://alioth.debian.org/projects/latrine/"
SRC_URI="http://alioth.debian.org/frs/download.php/3085/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sys-libs/ncurses[unicode]
	dev-db/sqlite:3"
DEPEND="${RDEPEND}
	sys-devel/autoconf-archive"

src_prepare() {
	epatch "${FILESDIR}/options-constness.patch" "${FILESDIR}/latrine-malloc.patch"
}

src_configure() {
	cd "${S}"/src && CC=$(tc-getCXX) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" econf
}

src_compile() {
	cd "${S}"/src && emake CC=$(tc-getCXX) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" DEB_BUILD_GNU_TYPE="" all mo
}

src_install() {
	cd "${S}"/src && emake DESTDIR="${D}" install DEB_BUILD_GNU_TYPE=""
	cd "${S}"
	dodoc CHANGES README TODO
	insinto /usr/share/${PN}/keymap
	doins keymap/*
}
