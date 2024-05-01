# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="browse output of processes"
HOMEPAGE="https://bosh.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN}/${PN}%20${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="sys-libs/ncurses:0"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README TODO )
