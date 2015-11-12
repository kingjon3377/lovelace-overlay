# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="a simple email archiver"
HOMEPAGE="http://adc-archmbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/adc-archmbox/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
