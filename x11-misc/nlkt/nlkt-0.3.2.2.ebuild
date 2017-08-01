# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# I don't remember where I got this, if I didn't write it myself.
# TODO: test, then submit if working.

EAPI=5

inherit qt4-r2

DESCRIPTION="non-linear keyboard trainer"
HOMEPAGE="http://sf.net/projects/nlkt"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${PN}-src_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4
	x11-libs/qwt:6[qt4]"
RDEPEND="${DEPEND}
	games-misc/fortune-mod"

S="${WORKDIR}/${P}/src"

src_prepare() {
	sed -i -e 's:INCLUDEPATH += /usr/include/qwt:INCLUDEPATH += /usr/include/qwt6:' \
		-e "s:LIBS += -lqwt:LIBS += -lqwt6-qt4:" nlkt.pro || die "sed failed"
}

src_configure() {
	eqmake4
}

src_compile() {
	lrelease nlkt.pro || die "compiling translations failed"
	emake PATH_CFG=-DNLKT_USE_SYSTEM_PATH
	rm Makefile*
}

src_install() {
	eqmake4 && emake INSTALL_ROOT="${D}" install
}
