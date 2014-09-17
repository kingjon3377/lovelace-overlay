# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="a fixed-point calculator that operates as a full-screen editor (tapecalc in Debian)"
HOMEPAGE="http://invisible-island.net/add/add.html"
SRC_URI="http://invisible-island.net/datafiles/release/${PN}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_compile() {
	default_src_compile
	emake docs
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc CHANGES README ${PN}.txt
	dohtml ${PN}.html
}
