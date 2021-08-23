# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Text gatherer for Fronttalk"
HOMEPAGE="https://www.unixpapa.com/gate.html"
SRC_URI="https://www.unixpapa.com/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# FIXME: Port to modern ncurses instead of -ltermcap
DEPEND="app-text/aspell
	>=sys-libs/libtermcap-compat-2.0.8-r5:="
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/term.c.patch"
	"${FILESDIR}/${P}-declare-void.patch"
	"${FILESDIR}/${P}-implicit-definitions.patch"
	"${FILESDIR}/${P}-multiple-definition.patch"
)

src_prepare() {
	default
	sed -i -e 's/getline/gate_getline/' gate.h line.c main.c spel.c subs.c || \
		die "sed failed"
	sed -i -e 's/Termcap too big.  %d/Termcap too big.  %ld/' term.c || \
		die "sed failed"
}

src_configure() {
	CC=$(tc-getCC) LD=$(tc-getLD) econf --with-aspell
	sed -i -e 's:/usr/share:${prefix}/share:' Makefile || die "sed failed"
}

src_install() {
	emake prefix="${D}/usr" install
	dodoc README
}
