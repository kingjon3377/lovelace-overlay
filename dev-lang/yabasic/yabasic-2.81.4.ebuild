# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Yet Another BASIC interpreter"
HOMEPAGE="http://www.yabasic.de"
SRC_URI="http://www.${PN}.de/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

# Fails 3 tests, marcIhm/yabasic#22
RESTRICT=test

RDEPEND="sys-libs/ncurses:0
	x11-libs/libX11
	x11-libs/libICE"
DEPEND="${DEPEND}
	test? ( app-misc/tmux )"

src_configure() {
	tc-export CC
	default
}

DOCS=( ChangeLog README NEWS AUTHORS ${PN}.htm )
