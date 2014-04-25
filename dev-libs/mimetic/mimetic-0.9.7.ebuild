# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# From Gentoo bug #77168

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="free/GPL Email library (MIME) written in C++"
SRC_URI="http://codesink.org/download/${P}.tar.gz"
HOMEPAGE="http://codesink.org/mimetic_mime_library.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~x86"

DEPEND="dev-libs/STLport"
RDEPEND="${DEPEND}"
IUSE=""

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README NEWS AUTHORS TODO ChangeLog
}
