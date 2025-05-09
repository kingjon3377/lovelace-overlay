# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Lightweight curses spreadsheet based on GNU oleo"
HOMEPAGE="https://github.com/blippy/neoleo"
SRC_URI="https://github.com/blippy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="sys-libs/ncurses:0"
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_test() {
	TZ=UTC default
}

src_install() {
	emake DESTDIR="${D}" generaldir="/usr/share/doc/${PF}" \
		exampledir="/usr/share/doc/${PF}/examples" install
	einstalldocs
	rm "${D}/usr/share/doc/${PF}/INSTALL"-*
}
