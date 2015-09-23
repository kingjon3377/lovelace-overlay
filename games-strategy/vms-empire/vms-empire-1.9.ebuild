# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

DESCRIPTION="the war game of the century"
HOMEPAGE="http://www.catb.org/~esr/vms-empire/"
SRC_URI="http://www.catb.org/~esr/vms-empire/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dogamesbin vms-empire
	newman empire.6 vms-empire.6
	dodoc BUGS NEWS README
}
