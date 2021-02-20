# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
BDEPEND="sys-devel/bison
	sys-devel/flex"
DEPEND="${RDEPEND}
	test? ( app-misc/tmux )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	tc-export CC
	default
	# marcIhm/yabasic#47
	if has_version 'sys-libs/ncurses[tinfo]'; then
		sed -i -e 's@-lcurses@& -ltinfo@' Makefile || die
	fi
}

DOCS=( ChangeLog README NEWS AUTHORS ${PN}.htm )
