# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils gnome2 toolchain-funcs

MY_P=${PN/n/N}-${PV}
DESCRIPTION="program that tries to learn a human language"
HOMEPAGE="http://gniall.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${MY_P}.tar.gz"

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

src_unpack() {
	default_src_unpack
	cd "${WORKDIR}"
	mv -i gNiall-${PV} ${P} || die "fixing directory name failed"
}

src_prepare() {
	epatch "${FILESDIR}"/gniall_0.7.1-7.diff
	cd "${S}" && mv -i otherStuff/console.c . || die "moving console.c failed"
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
	doman "${FILESDIR}"/gniall.6 || die "doman failed"
	make_desktop_entry /usr/bin/gniall gNiall "" Games/Toys
}
