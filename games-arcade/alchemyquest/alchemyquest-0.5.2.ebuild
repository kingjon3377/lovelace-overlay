# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop

DESCRIPTION="Modernization of OpenAlchemist"
HOMEPAGE="https://gitlab.com/dulsi/alchemyquest https://identicalsoftware.com/alchemyquest/"
SRC_URI="https://gitlab.com/dulsi/${PN}/-/archive/release-${PV}/${PN}-release-${PV}.tar.bz2"

LICENSE="GPL-2+ CC-BY-SA-2.0 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/libsdl2:=
	media-libs/sdl2-image:=
	media-libs/sdl2-mixer:=
	dev-libs/boost:=
	dev-libs/expat:=
	dev-libs/libzip:="
RDEPEND="${DEPEND}
	!!games-arcade/openalchemist"

S="${WORKDIR}/${PN}-release-${PV}"

src_install() {
	cmake_src_install
	dosym alchemyquest /usr/bin/openalchemist
	domenu ${PN}.desktop openalchemist.desktop
	insinto /usr/share/metainfo
	for name in ${PN} openalchemist;do
		newins ${name}.appdata.xml ${name}.metainfo.xml
	done
}
