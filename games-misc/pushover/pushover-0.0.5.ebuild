# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Pushover is a fun puzzle game originally published by Ocean in 1992."
HOMEPAGE="http://pushover.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

# Tests rely on data that isn't distributed in the tarball.
RESTRICT="test"
DEPEND="dev-lang/lua:0
	media-libs/sdl-mixer
	media-libs/sdl-ttf"
RDEPEND="${DEPEND}"
