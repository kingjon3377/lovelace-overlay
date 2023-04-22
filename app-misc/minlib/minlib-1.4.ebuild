# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Text-based library management program"
HOMEPAGE="https://dgoodmaniii.codeberg.page/minlib/"
SRC_URI="https://codeberg.org/dgoodmaniii/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libextractor
	sys-libs/ncurses:0[unicode(+)]"
RDEPEND="${DEPEND}
	app-text/poppler
	app-arch/unzip"
BDEPEND=""

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" prefix=/usr
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	emake prefix="${D}/usr" docdir="${D}/usr/share/doc/${PF}" install
	dodoc README.md
}
