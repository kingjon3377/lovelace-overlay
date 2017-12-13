# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# I wrote this; if it works, submit.

EAPI=5

EGIT_REPO_URI="git://git.berlios.de/boats"
inherit qt4-r2 git-r3 eutils

DESCRIPTION="a race scenario drawing tool"
HOMEPAGE="http://boats.berlios.de"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/giflib
	dev-qt/qtcore:4
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

src_compile() {
	emake
}

src_install() {
	dobin ${PN}
	insinto /usr/share/applications
	doins ${PN}.desktop
	for a in 32x32/mimetypes/application-x-boats.png \
			32x32/apps/boats.png 16x16/mimetypes/application-x-boats.png \
			16x16/apps/boats.png 48x48/mimetypes/application-x-boats.png \
			48x48/apps/boats.png 128x128/apps/boats.png; do
		insinto /usr/share/icons/hicolor/$(dirname ${a})
		doins images/icons/hicolor/${a}
	done
	doicon images/icons/hicolor/128x128/apps/${PN}.png
	insinto /usr/share/mime/packages
	doins ${PN}.xml
	insinto /usr/share/${PN}
	doins locale/*qm
	dodoc TODO
	doman doc/${PN}.1
}
