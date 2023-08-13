# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="fixed-point calculator operating as a full-screen editor (tapecalc in Debian)"
HOMEPAGE="https://invisible-island.net/add/add.html"
SRC_URI="https://invisible-island.net/archives/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/ncurses:0"
RDEPEND="${DEPEND}"

DOCS=( CHANGES README ${PN}.txt ${PN}.html )

src_prepare() {
	sed -i -e 's@flash@& raw@' configure.in || die
	default
	eautoreconf
}

src_configure() {
	default
	if has_version 'sys-libs/ncurses[tinfo]' ; then
		sed -i -e 's@-lncurses@& -ltinfo@' makefile || die
	fi
}

src_compile() {
	default_src_compile
	emake docs
}
