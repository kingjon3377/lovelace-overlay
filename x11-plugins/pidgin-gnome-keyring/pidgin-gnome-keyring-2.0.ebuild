# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib toolchain-funcs

DESCRIPTION="System keyring integration for pidgin"
HOMEPAGE="https://github.com/aebrahim/pidgin-gnome-keyring"
SRC_URI="https://github.com/aebrahim/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="net-im/pidgin
	app-crypt/libsecret"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i -e 's@/lib/@/'"$(get_libdir)"'/@g' Makefile || die
	if ! test -s VERSION; then
		echo "${PV}" > VERSION
	fi
}

src_compile() {
	CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" emake all
}

src_install() {
	emake DESTDIR="${ED}" install
	dodir README
	# TODO: What, if anything, should we do with the logo?
}
