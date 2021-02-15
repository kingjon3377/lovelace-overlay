# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# I wrote this; if it works, submit.

EAPI=7

inherit qmake-utils desktop

DESCRIPTION="a race scenario drawing tool"
HOMEPAGE="http://boats.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${PN}_${PV}_src.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/giflib
	dev-qt/qtcore:5
	dev-qt/qtgui:5"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5
}

src_install() {
	dobin ${PN}
	insinto /usr/share/applications
	# FIXME: .desktop fails validation
	doins resources/${PN}.desktop
	for size in 32 16 48 ; do
		base=icons/hicolor/${size}x${size}
		insinto /usr/share/${base}/mimetypes
		doins images/${base}/mimetypes/application-x-${PN}.png
		insinto /usr/share/${base}/apps
		doins images/${base}/apps/${PN}.png
	done
	insinto /usr/share/icons/hicolor/128x128/apps
	doins images/icons/hicolor/128x128/apps/${PN}.png
	doicon images/icons/hicolor/128x128/apps/${PN}.png
	insinto /usr/share/mime/packages
	doins resources/${PN}.xml
	insinto /usr/share/${PN}
	doins locale/*qm
	dodoc TODO
	doman doc/${PN}.1
}
