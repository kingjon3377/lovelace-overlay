# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

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

DOCS=( README.txt )

PATCHES=( "${FILESDIR}/printf.patch" )
