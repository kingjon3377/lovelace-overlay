# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

DESCRIPTION="QuiteRSS fork with Qt6 and without WebEngine"
HOMEPAGE="https://github.com/birdie-github/notquiterss"
SRC_URI="https://github.com/birdie-github/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-db/sqlite:3
	dev-libs/libxml2:=
	dev-qt/qtbase:6[gui,widgets,cups,network,sql,sqlite,xml]
	dev-qt/qtsvg:6
	dev-qt/qt5compat:6
	dev-qt/qtsingleapplication:6
	dev-qt/qttools:6[linguist]
	>=dev-libs/miniaudio-0.11.25:="
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	eqmake6 CONFIG+=release USE_QT=6 PREFIX=/usr MINIAUDIO_INCLUDE_DIR=/usr/include/miniaudio
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs
}
