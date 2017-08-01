# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools flag-o-matic

DESCRIPTION="A Staticly typed, imperative programming language"
HOMEPAGE="http://kayalang.org"
SRC_URI="http://kayalang.org/src/${P}.tgz"

IUSE="+gd +gnutls +pcre postgres +sdl +sqlite mysql"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/ghc:=
	dev-haskell/happy:=
	sys-libs/zlib
	dev-libs/libpcre
	dev-libs/libgcrypt:0
	dev-libs/boehm-gc
	gnutls? ( net-libs/gnutls )
	pcre? ( dev-libs/libpcre )
	postgres? ( dev-db/postgresql:= )
	sqlite? ( dev-db/sqlite:3 )
	   sdl? ( media-libs/libsdl )
	gd? ( media-libs/gd )
	media-libs/freeglut
	media-libs/mesa
	sys-libs/ncurses:0
	mysql? ( dev-db/mysql ) "

DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-conf.patch" \
		"${FILESDIR}/${P}-smp.patch" \
		"${FILESDIR}/${P}-urandom.patch" \
		"${FILESDIR}/${PN}-0.5.2-codegen.patch" \
		"${FILESDIR}/haskell.patch"

	filter-flags -D_FORTIFY_SOURCE=2

	eautoreconf
}

src_install() {
	make install DESTDIR="${D}" ibdir="/usr/$(get_libdir)/kaya"
	docinto examples/cookies
	dodoc examples/cookies/*
	docinto examples/display
	dodoc examples/display/*
	docinto examples/lam
	dodoc examples/lam/*
	docinto examples/misc
	dodoc examples/misc/*
	docinto examples/parser
	dodoc examples/parser/*
	docinto examples/shape
	dodoc examples/shape/*
	docinto examples/sudoku
	dodoc examples/sudoku/*
	docinto examples/upload
	dodoc examples/upload/*
	docinto examples/webapps
	dodoc examples/webapps/*
	docinto docs
	dodoc docs/*
}
