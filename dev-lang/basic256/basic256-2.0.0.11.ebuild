# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="educational BASIC programming environment for children"
HOMEPAGE="https://www.basic256.org/"
SRC_URI="mirror://sourceforge/kidbasic/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="l10n_en l10n_de l10n_es l10n_fr l10n_nl l10n_ru"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtserialport:5
	media-libs/sdl-mixer
	dev-db/sqlite:3
	|| ( app-accessibility/espeak-ng app-accessibility/espeak )"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

DOCS=( ChangeLog CONTRIBUTORS )

PATCHES=( "${FILESDIR}/${P}-espeak-execute.patch" )

src_configure() {
	eqmake5 ${PN^^}.pro
}

src_install() {
	doman "${FILESDIR}/${PN}.1"
	INSTALL_ROOT="${D}" default
}
