# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/recode/recode-3.6_p17-r2.ebuild,v 1.13 2012/06/13 13:23:02 darkside Exp $

EAPI="5"
inherit autotools eutils flag-o-matic libtool toolchain-funcs

MY_P=${P%_*}
MY_PV=${PV%_*}
DEB_PATCH=${PV#*p}

DESCRIPTION="Convert files between various character sets"
HOMEPAGE="http://recode.progiciels-bpi.ca/"
SRC_URI="mirror://gnu/${PN}/${MY_P}.tar.gz
	mirror://debian/pool/main/r/${PN}/${PN}_${MY_PV}-${DEB_PATCH}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="nls static-libs"

DEPEND="
	sys-devel/flex
	nls? ( sys-devel/gettext )"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch \
		"${FILESDIR}/${MY_P}-gettextfix.diff" \
		"${FILESDIR}"/${MY_P}-as-if.patch \
		"${WORKDIR}"/${PN}_${MY_PV}-${DEB_PATCH}.diff
	sed -i '1i#include <stdlib.h>' src/argmatch.c || die

	# Remove old libtool macros
	rm "${S}"/acinclude.m4

	# As per bug #419455, fix build with recent automake; upstream patch doesn't apply cleanly.
	sed -i -e '/^AM_C_PROTOTYPES/d'  configure.in || die
	sed -i -e 's/ansi2knr//' src/Makefile.am || die

	eautoreconf
	elibtoolize
}

src_configure() {
	tc-export CC LD
	# on solaris -lintl is needed to compile
	[[ ${CHOST} == *-solaris* ]] && append-libs "-lintl"
	# --without-included-gettext means we always use system headers
	# and library
	econf \
		--without-included-gettext \
		$(use_enable nls) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install
	prune_libtool_files --all
	dodoc AUTHORS BACKLOG ChangeLog NEWS README THANKS TODO
	rm -f "${ED}"/usr/lib/charset.alias
}
