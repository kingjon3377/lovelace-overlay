# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="non-linear keyboard trainer"
HOMEPAGE="https://sourceforge.net/projects/nlkt"
SRC_URI="mirror://debian/pool/main/n/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

COMMON_DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	x11-libs/qwt:6[qt5(+)]"
DEPEND="${COMMON_DEPEND}
	dev-qt/linguist-tools:5"
RDEPEND="${COMMON_DEPEND}
	games-misc/fortune-mod"

src_prepare() {
	sed -i -e 's@SHARE_PREFIX "@"/usr/share/nlkt/@' src/Path.hpp || die
	sed -i -e 's@<qwt/@<qwt6/@' src/StatsWidget.cpp || die
	sed -i -e 's@qwt-qt5@qwt6-qt5@' src/CMakeLists.txt || die
	cmake-utils_src_prepare
}

src_configure() {
	mycmakeargs=(
		"-DLOCAL=off"
	)
	cmake-utils_src_configure
}
