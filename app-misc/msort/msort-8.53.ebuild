# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit libtool eutils

DESCRIPTION="Unicode enabled sorting utility"
HOMEPAGE="http://billposer.org/Software/msort.html"
SRC_URI="http://billposer.org/Software/Downloads/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="
	>=dev-libs/tre-0.8.0
	>=dev-lang/tk-8.3
	dev-tcltk/iwidgets
	dev-libs/icu"
RDEPEND=""

#src_prepare() {
#	sed -i -e 's:-licutu:-licutu -licuuc:' Makefile.in
#}

src_configure() {
	econf --disable-utf8proc --disable-uninum
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README NEWS ChangeLog AUTHORS
}
