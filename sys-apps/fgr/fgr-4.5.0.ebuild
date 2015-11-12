# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
DESCRIPTION="Fgr Command Find Tool"
HOMEPAGE="http://xffm.sourceforge.net/fgr.html"
SRC_URI="http://downloads.sourceforge.net/xffm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=">=dev-libs/glib-2.6.0"

RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install
}
