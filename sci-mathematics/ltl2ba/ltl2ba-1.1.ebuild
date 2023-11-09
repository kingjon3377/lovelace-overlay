# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Fast LTL to Buechi Automata Translation"
HOMEPAGE="http://www.lsv.ens-cachan.fr/~gastin/ltl2ba/"
SRC_URI="http://www.lsv.ens-cachan.fr/~gastin/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	sed -i Makefile \
		-e "s/CC=gcc/#CC=gcc/g" \
		-e "s/CFLAGS= -O3 -ansi -DNXT/CFLAGS+= -ansi -DNXT -fcommon/g"
	default
}

src_install() {
	dobin ${PN}
	dodoc README
}
