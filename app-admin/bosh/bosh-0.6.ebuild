# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="browse output of processes"
HOMEPAGE="http://bosh.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PN}%20${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-libs/ncurses:0"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README TODO )
