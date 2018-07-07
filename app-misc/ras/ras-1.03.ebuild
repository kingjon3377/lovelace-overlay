# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Adds redundancy files to archives for data recovery"
HOMEPAGE="http://www.cleaton.net/ras/"
SRC_URI="https://www.ibiblio.org/pub/Linux/utils/file/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( README NEWS )

src_prepare() {
	default
	tc-export CC
}
