# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{2..5} )

inherit desktop python-any-r1 cmake

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
BDEPEND="${PYTHON_DEPS}"

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
	cmake_src_prepare
	#changes path to data files
	einfo "Removing hard-coded paths to data files"
	sed -is "s?\"data\"?\"/${EPREFIX}/usr/${PN}\"?" quackletest.cpp quacker/settings.cpp || die
	sed -is "s?../data?${EPREIX}/usr/${PN}?" quacker/settings.cpp encodeleaves/encodeleaves.cpp \
		makeminidawg/makeminidawgmain.cpp || die
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=/usr/$(get_libdir)
		-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
	)
	if test -z "${CMAKE_IN_SOURCE_BUILD}";then
		CMAKE_USE_DIR="${S}/quacker" BUILD_DIR="${S}_build/quacker" cmake_src_configure
	else
		CMAKE_USE_DIR="${S}/quacker" cmake_src_configure
	fi
}

src_compile() {
	if test -z "${CMAKE_IN_SOURCE_BUILD}";then
		CMAKE_USE_DIR="${S}/quacker" BUILD_DIR="${S}_build/quacker" cmake_src_compile
	else
		CMAKE_USE_DIR="${S}/quacker" cmake_src_compile
	fi
}

src_test() {
	if test -z "${CMAKE_IN_SOURCE_BUILD}";then
		args=( --bin "${S}_build/quacker/test/libquackle_test" )
		libpath="${S}_build/quacker/libquackle:${S}_build/quacker/quackleio"
	else
		args=( )
		# FIXME: These paths are almost certainly wrong
		libpath="${S}:${S}/quackleio"
	fi
	local -x LD_LIBRARY_PATH="${libpath}:$LD_LIBRARY_PATH"
	"${PYTHON}" test/regression/run_regression.py "${args[@]}" || die "regression test failed"
}

src_install() {
	# FIXME: "insecure rpath"
	if test -z "${CMAKE_IN_SOURCE_BUILD}";then
		newbin "${S}_build/quacker/Quackle" ${PN}
		dolib.so "${S}_build/quacker/libquackle/libquackle.so" "${S}_build/quacker/quackleio/libquackleio.so"
	else
		newbin "${S}"/quacker/Quackle ${PN}
		# FIXME: These paths are almost certainly wrong
		dolib.so "${S}/libquackle.so" "${S}/quackleio/libquackleio.so"
	fi

	insinto /usr/share/${PN}
	doins -r data/*

	doicon "${FILESDIR}"/quackle.png
	make_desktop_entry quackle "Quackle" quackle "Game;BoardGame"
}
