# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit qmake-utils

DESCRIPTION="Personal Finances Manager for KDE."
HOMEPAGE="https://eqonomize.github.io"
SRC_URI="https://github.com/${PN/e/E}/${PN}/releases/download/v${PV}.0/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# TODO: What other Qt modules does it require?
RDEPEND="dev-qt/qtcharts:5"
DEPEND="${RDEPEND}"

src_configure() {
	PREFIX="${EPREFIX}/usr" eqmake5
}

src_install() {
	INSTALL_ROOT="${D}" default
}
