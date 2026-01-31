# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# I wrote this; if it works, submit.

EAPI=8

inherit qmake-utils desktop

DESCRIPTION="a race scenario drawing tool"
HOMEPAGE="https://boats.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PV}/${PN}_${PV}_src.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/giflib
	dev-qt/qtcore:5
	dev-qt/qtgui:5"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5
}

src_install() {
	dobin ${PN}
	# FIXME: .desktop fails validation
	domenu resources/${PN}.desktop
	for size in 32 16 48 ; do
		base=icons/hicolor/${size}x${size}
		doicon -s ${size} -c mimetypes images/${base}/mimetypes/application-x-${PN}.png
		doicon -s ${size} images/${base}/apps/${PN}.png
	done
	doicon -s 128 images/icons/hicolor/128x128/apps/${PN}.png
	doicon images/icons/hicolor/128x128/apps/${PN}.png
	insinto /usr/share/mime/packages
	doins resources/${PN}.xml
	insinto /usr/share/${PN}
	doins locale/*qm
	dodoc TODO
	doman doc/${PN}.1
}
