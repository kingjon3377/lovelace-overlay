# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="fixed-point calculator operating as a full-screen editor (tapecalc in Debian)"
HOMEPAGE="http://invisible-island.net/add/add.html"
SRC_URI="http://invisible-island.net/datafiles/release/${PN}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-libs/ncurses:0"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	dodoc CHANGES README
}
