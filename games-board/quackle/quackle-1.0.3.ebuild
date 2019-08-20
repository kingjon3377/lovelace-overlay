# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils

DESCRIPTION="Crossword game AI and analysis tool that also plays Scrabble"
HOMEPAGE="https://people.csail.mit.edu/jasonkb/quackle/ https://github.com/quackle/quackle"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-qt/qtgui:5
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/quackle-1.0.3-qt5-0c4f091e74a5c6d1e0b5f4cf47670bd1c3e1e3e6.patch"
	"${FILESDIR}/quackle-1.0.3-more-qt5-67059305e164f3b741c36d4e0ac22022c9b79901.patch"
	"${FILESDIR}/quackle-1.0.3-fix-segfault.patch"
)

quackle_subdirs=(
	quackleio
	quacker
	encodeleaves
	gaddagize
	makegaddag
	makeminidawg
)

src_prepare() {
	default
	#changes path to data files
	einfo "Removing hard-coded paths to data files"
	sed -is "s?\"data\"?\"/${EPREFIX}/usr/${PN}\"?" quackletest.cpp quacker/settings.cpp || die
	sed -is "s?../data?${EPREIX}/usr/${PN}?" quacker/settings.cpp encodeleaves/encodeleaves.cpp makeminidawg/makeminidawgmain.cpp || die
	# fix qmake failure
	sed -i -e 's@:!win32-msvc2013@@' test/test.pro gaddagize/gaddagize.pro makegaddag/makegaddag.pro \
		makeminidawg/makeminidawg.pro || die
}

src_configure() {
	eqmake5
	for dir in "${quackle_subdirs[@]}";do
		cd "${S}/${dir}" || die "cd failed"
		eqmake5
	done
	if use test; then
		cd "${S}/quackleio/iotest" || die "cd failed"
		eqmake5
		cd "${S}/test" || die "cd failed"
		eqmake5
	fi
}

src_compile() {
	emake
	for dir in "${quackle_subdirs[@]}";do
		emake -C "${dir}"
	done
	if use test; then
		emake -C quackleio/iotest
		emake -C test
	fi
}

src_install() {
	newbin "${S}"/quacker/Quackle ${PN}

	insinto /usr/share/${PN}
	doins -r data/*

	doicon "${FILESDIR}"/quackle.png
	make_desktop_entry quackle "Quackle" quackle "Game;BoardGame"
}

src_test() {
	cd test
	./test --mode=selfplay --quiet || die "test failed"
}
