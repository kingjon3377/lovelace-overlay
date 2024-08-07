# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="AI evolution simulation"
HOMEPAGE="https://critterding.sourceforge.net"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN}/sources/${PN}-beta${PV}.tar.bz2"

S="${WORKDIR}/${PN}-beta${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/freetype:2
	media-libs/libsdl"
DEPEND="${RDEPEND}"
BDEPEND=">=sys-devel/gcc-4.2"

#src_prepare() {
	#eautoreconf
#}

src_compile() {
	cmake_src_compile
}

DOCS=( AUTHORS Changelog README )

src_install() {
	cmake_src_install
	insinto "/usr/share/${PN}/profiles"
	doins profiles/race
}
