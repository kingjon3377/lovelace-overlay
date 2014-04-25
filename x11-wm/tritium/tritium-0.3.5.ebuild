# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="A tiling window manager like ion3"
HOMEPAGE="http://tritium.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-wm/plwm"
RDEPEND="${DEPEND}"
