# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

AUTOTOOLS_IN_SOURCE_BUILD=true

inherit eutils autotools

DESCRIPTION="A tetris clone with multiplayer support"
HOMEPAGE="https://github.com/quadra-game/quadra"
SRC_URI="https://github.com/${PN}-game/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/zlib
	media-libs/libpng:0=
	media-libs/libsdl2
	dev-libs/boost"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "/^datagamesdir:=/s:/games:/${PN}:" Makefile.am || die
	default
	eautoreconf
}

DOCS=( NEWS.md )

src_install() {
	default
	# TODO: install demos?
	make_desktop_entry ${PN} Quadra
}
