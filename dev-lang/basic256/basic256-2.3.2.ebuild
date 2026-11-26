# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop

DESCRIPTION="educational BASIC programming environment for children"
HOMEPAGE="https://www.basic256.org/"
SRC_URI="https://github.com/uglymike17/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="l10n_en l10n_de l10n_es l10n_fr l10n_nl l10n_ru"

RDEPEND="dev-qt/qtbase:6=[gui,widgets,sql,network]
	dev-qt/qtserialport:6=
	dev-qt/qtmultimedia:6=
	dev-qt/qtspeech:6=
	dev-qt/qttools:6=[linguist]
"
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/flex
	sys-devel/bison"

DOCS=( ChangeLog CONTRIBUTORS README.md )

src_install() {
	cmake_src_install
	doicon -s 64x64 resources/icons/${PN}.png
	newicon -s 256x256 resources/icons/${PN}_256.png ${PN}.png
	insinto /usr/share/applications
	doins "${FILESDIR}/${PN}.desktop"
	dodoc -r Examples
	doman "${FILESDIR}/${PN}.1"
	insinto /usr/share/${PN}
	doins "${BUILD_DIR}/${PN}"_*.qm
}
