# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="perceptual image comparison tool"
HOMEPAGE="https://pdiff.sourceforge.net"
SRC_URI="https://downloads.sourceforge.net/pdiff/pdiff/${P}/${P}-src.tar.gz"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/freeimage"
RDEPEND="${DEPEND}"

DOCS=( README.txt )

PATCHES=( "${FILESDIR}/printf.patch" )
