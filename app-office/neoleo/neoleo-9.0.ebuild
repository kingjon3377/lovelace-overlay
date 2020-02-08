# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Lightweight curses spreadsheet based on GNU oleo"
HOMEPAGE="https://github.com/blippy/neoleo"
SRC_URI="https://github.com/blippy/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses:0"
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig"

src_prepare() {
	default
	sed -i -e 's@ -Wfatal-errors@@' -e 's@ -Werror@@' src/Makefile.in || die
}

src_test() {
	TZ=UTC default
}

src_install() {
	emake DESTDIR="${D}" generaldir="/usr/share/doc/${PF}" \
		examplesdir="/usr/share/doc/${PF}/examples" install
	einstalldocs
}