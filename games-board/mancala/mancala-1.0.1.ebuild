# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Implementation of the simple board game called Mancala"
HOMEPAGE="https://shh.thathost.com/pub-unix/#Mancala"
SRC_URI="https://shh.thathost.com/pub-unix/files/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64"

DEPEND="x11-libs/libX11
	x11-libs/xforms"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/mancala_1.0.1-3.diff"
)

src_compile() {
	emake CC=$(tc-getCC) XLIBDIR= OPTIM="${CFLAGS}" LDOPT="-L. ${LDFLAGS}"
}

src_install() {
	dobin mancala xmancala debian/mancala-text
	dodoc README RULES mancala-1.0.1.lsm
	doman debian/mancala.6
}
