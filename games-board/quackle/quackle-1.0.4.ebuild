# Copyright 1999-2022 Gentoo Authors
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

RESTRICT="!test? ( test )"

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
	sed -is "s?../data?${EPREIX}/usr/${PN}?" quacker/settings.cpp encodeleaves/encodeleaves.cpp \
		makeminidawg/makeminidawgmain.cpp || die
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
