# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EHG_REVISION="4b8109987265"

DESCRIPTION="Blender exporter for luxrender"
HOMEPAGE="http://www.luxrender.net"
SRC_URI="http://src.luxrender.net/luxblend/archive/${EHG_REVISION}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="media-gfx/blender:0"
DEPEND=""

S="${WORKDIR}/luxblend-${EHG_REVISION}"

src_install() {
	insinto /usr/share/blender/scripts/
	doins LuxBlend_0.1.py
}
