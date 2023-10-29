# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="the war game of the century"
HOMEPAGE="http://www.catb.org/~esr/vms-empire/ https://gitlab.com/esr/vms-empire"
SRC_URI="http://www.catb.org/~esr/vms-empire/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

DOCS=( BUGS NEWS README HACKING )

src_prepare() {
	default
	tc-export CC
	if has_version 'sys-libs/ncurses[tinfo]'; then
		sed -i -e 's@-lncurses@& -ltinfo@' Makefile || die
	fi
}
