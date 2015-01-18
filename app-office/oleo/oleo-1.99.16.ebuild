# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="GNU spreadsheet program"
HOMEPAGE="http://www.gnu.org/software/oleo/"
SRC_URI="http://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="+X +motif"

DEPEND="sys-libs/ncurses
	sys-devel/gettext
	sys-apps/texinfo
	X? ( x11-libs/libX11 )
	motif? ( x11-libs/motif
		x11-libs/xbae
		media-libs/plotutils )"
RDEPEND="${DEPEND}"

REQUIRED_USE="motif? ( X )"

src_prepare() {
	epatch "${FILESDIR}/oleo_1.99.16-10ubuntu1.diff" "${FILESDIR}/label.patch"
}

src_configure() {
	local myconf
	if use motif; then
		myconf=""
	elif use X; then
		myconf="--without-motif"
	else
		myconf="--without-x"
	fi
	default_src_configure ${myconf}
}

src_compile() {
	default_src_compile CC=$(tc-getCC) "CFLAGS=${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	sed -i -e 's:prefix = /usr:prefix = $(DESTDIR)/usr:' po/Makefile || die "hack to avoid sandbox violation failed"
	emake DESTDIR="${D}" install
	doman debian/oleo.1
	dodoc AUTHORS FAQ NEWS README* THANKS TODO debian/copyright debian/changelog ChangeLog
	docinto examples && dodoc examples/*
	domenu debian/oleo.desktop
	rm -r "${D}"/usr/Oleo || die "fixing mis-installed docs failed"
}
