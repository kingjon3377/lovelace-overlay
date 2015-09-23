# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="measure and display the rate of data across a network connection"
HOMEPAGE="http://excess.org/speedometer"
SRC_URI="http://excess.org/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/urwid"
RDEPEND="${DEPEND}"

src_install() {
	newbin ${PN}.py ${PN}
}
