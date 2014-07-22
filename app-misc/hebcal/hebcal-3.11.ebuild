# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="perpetual Jewish calendar"
HOMEPAGE="http://www.sadinoff.com/hebcal"
SRC_URI="mirror://sourceforge/${PN}/${PN}-c/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	# It's empty; we want to rebuild it from source properly.
	rm doc/${PN}.info
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog HACKING NEWS OLD_NEWS README TODO
}
