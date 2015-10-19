# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games

DESCRIPTION="Pushover is a fun puzzle game originally published by Ocean in 1992."
HOMEPAGE="http://pushover.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

# Tests rely on data that isn't distributed in the tarball.
RESTRICT="test"
DEPEND="dev-lang/lua:0
	media-libs/sdl-mixer
	media-libs/sdl-ttf"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
}
