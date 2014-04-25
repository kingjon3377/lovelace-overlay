# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils

DESCRIPTION="perceptual image comparison tool"
HOMEPAGE="http://pdiff.sourceforge.net"
SRC_URI="mirror://sourceforge/pdiff/pdiff/${P}/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/freeimage"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/*.patch
}

src_install() {
	cmake-utils_src_install
	dodoc README.txt
}
