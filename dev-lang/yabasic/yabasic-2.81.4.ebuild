# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs autotools

DESCRIPTION="Yet Another BASIC interpreter"
HOMEPAGE="http://www.yabasic.de"
SRC_URI="http://www.${PN}.de/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="sys-libs/ncurses:0
	x11-libs/libX11
	x11-libs/libICE"
DEPEND="${DEPEND}
	test? ( app-misc/tmux )"

src_prepare() {
	# See marcIhm/yabasic#22
	sed -i -e 's@^AUTOMAKE_OPTIONS =.*@& serial-tests@' Makefile.am || die
	sed -i -e 's@$OUT@"&"@' -e 's@-ne@!=@' tests/silent.sh || die
	default
	eautoreconf
}

src_configure() {
	tc-export CC
	default
}

DOCS=( ChangeLog README NEWS AUTHORS ${PN}.htm )
