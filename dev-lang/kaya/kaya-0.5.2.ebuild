# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

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
	dev-haskell/editline:=
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

# Tests fail; the regression framework built into the build system might be able
# to help with some of them (the "differences" are between broken and unbroken
# lines of text), but we just restrict the tests for the transition from
# per-machine overlays to a combined overlay.
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}/${P}-conf.patch"

#	epatch "${FILESDIR}/${P}-smp.patch"
	epatch "${FILESDIR}/${PN}-0.5.0-urandom.patch" \
		"${FILESDIR}/${PN}-0.5.2-readline.patch" \
		"${FILESDIR}/${PN}-0.5.2-codegen.patch" \
		"${FILESDIR}/${PN}-0.5.2-plugins.patch" \
		"${FILESDIR}/haskell.patch" \
		"${FILESDIR}/kaya-0.5.2-ghc7.6.patch"
	sed -i -e 's:import List:import Data.List:' \
		compiler/Options.hs compiler/CodegenCPP.hs \
		|| die "sed failed"

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
