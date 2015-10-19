# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
DESCRIPTION="Fgr Command Find Tool"
HOMEPAGE="http://xffm.sourceforge.net/fgr.html"
SRC_URI="mirror://sourceforge/xffm/${PV}/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-libs/glib-2.6.0"

# fgr is bundled with rodent
RDEPEND="${DEPEND}
	!x11-misc/rodent"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README TODO
}
