# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2

DESCRIPTION="Qt interface for Cuneiform"
HOMEPAGE="http://www.altlinux.org/Cuneiform-Qt"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtgui:4
	app-text/cuneiform"
RDEPEND="${DEPEND}"

DOCS="AUTHORS README TODO"

src_prepare() {
	sed 's:/share/apps/cuneiform-qt/:/share/cuneiform-qt/:' -i cuneiform-qt.pro || die "Cannot patch cuneiform-qt.pro"
}

src_configure() {
	PREFIX="/usr" eqmake4
}

src_compile () {
	emake
}
