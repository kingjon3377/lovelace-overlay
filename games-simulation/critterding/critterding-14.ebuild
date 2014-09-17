# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils games

DESCRIPTION="AI evolution simulation"
HOMEPAGE="http://critterding.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/sources/${PN}-beta${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-libs/freetype:2
	media-libs/libsdl"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.2"

S="${WORKDIR}/${PN}-beta${PV}"

#src_prepare() {
	#eautoreconf
#}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${GAMES_PREFIX}"
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	dodir "${GAMES_DATADIR}/${PN}/profiles"
	insinto "${GAMES_DATADIR}/${PN}/profiles"
	doins profiles/race
	dodoc AUTHORS Changelog README
	prepgamesdirs
}
