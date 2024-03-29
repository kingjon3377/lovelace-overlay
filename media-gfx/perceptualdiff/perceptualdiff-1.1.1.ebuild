# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="perceptual image comparison tool"
HOMEPAGE="https://pdiff.sourceforge.net"
SRC_URI="mirror://sourceforge/pdiff/pdiff/${P}/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/freeimage"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

DOCS=( README.txt )

PATCHES=( "${FILESDIR}/printf.patch" )
