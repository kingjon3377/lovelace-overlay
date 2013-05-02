# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils gnome2 toolchain-funcs

DESCRIPTION="program that tries to learn a human language"
HOMEPAGE="http://gniall.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/gNiall-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="gnome-base/libbonoboui
	gnome-base/libgnomeui
	gnome-base/libgnomecanvas
	gnome-base/gnome-vfs
	x11-libs/pango"
RDEPEND="${DEPEND}"

src_prepare() {
	cd "${WORKDIR}"
	mv -i gNiall-${PV} ${P} || die "fixing directory name failed"
	epatch "${FILESDIR}"/gniall_0.7.1-7.diff
	cd "${S}" && mv -i debian/gniall.1 debian/gniall.6 || die "switching man section failed"
	mv -i otherStuff/console.c . || die "moving console.c failed"
	default_src_prepare
}

src_compile() {
	default_src_compile
	$(tc-getCC) ${CFLAGS} niall.c console.c -o cNiall || die "compiling console version failed"
}

src_install() {
	gnome2_src_install
	dobin cNiall
	dodoc AUTHORS NEWS README ChangeLog TODO otherStuff/example.niall
	doman debian/gniall.6 || die "doman failed"
}
