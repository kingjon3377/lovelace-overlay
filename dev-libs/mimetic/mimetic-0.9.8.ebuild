# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# From Gentoo bug #77168

EAPI=5

inherit eutils toolchain-funcs autotools-utils

DESCRIPTION="free/GPL Email library (MIME) written in C++"
SRC_URI="http://www.codesink.org/download/${P}.tar.gz"
HOMEPAGE="http://www.codesink.org/mimetic_mime_library.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
IUSE="test static-libs"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	if ! use test;then
		sed -i -e '/^SUBDIRS/s/ test / /' Makefile.am || die
	fi
	eautoreconf
}

src_configure() {
	autotools-utils_src_configure
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_test() {
	emake -C test install
}

DOCS=( README NEWS AUTHORS ChangeLog )

src_install() {
	autotools-utils_src_install
}
