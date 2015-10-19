# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games qt4-r2

DESCRIPTION="Crossword game artificial intelligence and analysis tool that also plays Scrabble"
HOMEPAGE="http://quackle.org"
SRC_URI="http://people.csail.mit.edu/jasonkb/quackle/downloads/${P}/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-qt/qtgui:4"
DEPEND="${RDEPEND}
	dev-util/scons"

src_prepare() {
	#includes header to make C++ assert calls work
	epatch "${FILESDIR}"/0.95-gentoo-assert.patch

	#changes path to data files
	einfo "Removing hard-coded paths to data files"
	sed -is "s?\"data\"?\"${GAMES_DATADIR}/${PN}\"?" quackletest.cpp quacker/settings.cpp
	sed -is "s?../data?${GAMES_DATADIR}/${PN}?" quacker/settings.cpp encodeleaves/encodeleaves.cpp makeminidawg/makeminidawg.cpp

	#need to clean up distfile first
	touch Makefile
	emake mocclean distclean
	touch quackleio/Makefile
	emake -C quackleio mocclean distclean
	touch quacker/Makefile
	emake -C quacker mocclean distclean
	use test && touch test/Makefile && emake -C test mocclean distclean
}

src_configure() {
	eqmake4
	cd quackleio || die "cd failed"
	eqmake4
	einfo "Continuing in quacker"
	cd ../quacker || die "couldn't cd to quacker"
	eqmake4
	use test && cd ../test && eqmake4
}

src_compile() {
	emake
	emake -C quackleio
	emake -C quacker
	use test && emake -C test
}

src_install() {
	dogamesbin "${S}"/quacker/quacker

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/*

	doicon "${FILESDIR}"/quackle.png
	make_desktop_entry quacker "Quackle" quackle "Game;BoardGame"
}

src_test() {
	cd test
	./test --mode=selfplay --quiet || die "test failed"
}
