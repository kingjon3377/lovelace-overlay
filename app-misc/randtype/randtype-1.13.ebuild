# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs

DESCRIPTION="semi-random text typer"
HOMEPAGE="http://bjk.sourceforge.net/randtype/"
SRC_URI="mirror://sourceforge/bjk/randtype/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"

src_prepare() {
	gunzip randtype.1.gz
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LIBS="-lz ${LDFLAGS}"
}

src_install() {
	dobin randtype
	doman randtype.1
	dodoc BUGS ChangeLog
}
