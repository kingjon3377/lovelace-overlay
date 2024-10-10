# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit qmake-utils

DESCRIPTION="Personal Finances Manager for KDE."
HOMEPAGE="https://eqonomize.github.io"
SRC_URI="https://github.com/${PN/e/E}/${PN}/releases/download/v${PV}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

# qtbase for QtWidgets, QtNetwork, and QtPrintSupport
RDEPEND="dev-qt/qtcharts:6
	dev-qt/qtbase:6"
DEPEND="${RDEPEND}"

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr" DOCUMENTATION_DIR="${EPREFIX}/usr/share/doc/${PF}/html"
}

src_install() {
	INSTALL_ROOT="${D}" default
}
