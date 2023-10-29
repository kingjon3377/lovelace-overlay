# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Utility for matching boolean queries in text or html files"
HOMEPAGE="https://www.gnu.org/software/bool/bool.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RESTRICT="primaryuri"

PATCHES=(
	"${FILESDIR}/bool-0.2.2-fix-segfault.patch"
	"${FILESDIR}/long.patch"
	"${FILESDIR}/man_typo.patch"
)

src_configure() {
	default_src_configure
	sed -i -e "s:gcc:$(tc-getCC) ${CFLAGS} ${LDFLAGS}:" Makefile */Makefile || die "sed failed"
}

src_install() {
	dobin src/bool
	doman doc/bool.1
	dodoc NEWS ChangeLog README
}
