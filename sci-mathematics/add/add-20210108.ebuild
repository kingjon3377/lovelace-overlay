# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="fixed-point calculator operating as a full-screen editor (tapecalc in Debian)"
HOMEPAGE="https://invisible-island.net/add/add.html"
SRC_URI="ftp://ftp.invisible-island.net/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/ncurses:0"
RDEPEND="${DEPEND}"

DOCS=( CHANGES README ${PN}.txt ${PN}.html )

src_compile() {
	default_src_compile
	emake docs
}
