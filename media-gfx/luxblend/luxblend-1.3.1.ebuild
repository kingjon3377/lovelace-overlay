# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

EHG_REVISION="ad6536b0dda8"

DESCRIPTION="Blender exporter for luxrender"
HOMEPAGE="http://www.luxrender.net"
SRC_URI="https://bitbucket.org/luxrender/luxblend25/get/${EHG_REVISION}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-gfx/blender:0
	>=media-gfx/luxrender-${PV}"
DEPEND=""

S="${WORKDIR}/luxrender-luxblend25-${EHG_REVISION}"

src_prepare() {
	epatch "${FILESDIR}/luxrender_path.diff"
	sed -i 's|from.*import pylux|import pylux|' "src/luxrender/outputs/pure_api.py" || die
}

src_install() {
	insinto /usr/share/blender/scripts/addons
	doins -r src/luxrender
	dodoc devel_notes/*
}
