# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit multilib eutils toolchain-funcs

DESCRIPTION="Small dynamic tiling window manager for X11"
HOMEPAGE="http://www.scrotwm.org"
SRC_URI="http://www.scrotwm.org/snapshot/${P}.tgz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXrandr"
DEPEND="${RDEPEND}
	x11-misc/dmenu
	x11-libs/libXt
	x11-proto/xproto"

S=${WORKDIR}/${PF}/linux

src_prepare() {
	# reset hardcoded flags (useless for NON scrotwm developers)
	# FIX: LDFLAGS not respected and missing soname
	epatch "${FILESDIR}"/${PN}-${PV}-makefile.patch
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		PREFIX="/usr" \
		LIBDIR="/usr/$(get_libdir)" \
		|| die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PREFIX="/usr" \
		install || die "emake install failed"
}
