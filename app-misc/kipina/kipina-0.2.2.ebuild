# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="training program to log physical activities of athletes"
HOMEPAGE="http://kipina.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-libs/libxml2
	dev-libs/libxslt
	gnome-base/libglade
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	emake -C doc/reference DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README TODO
	mv "${D}/usr/share/gtk-doc/html/${PN}" "${D}/usr/share/doc/${PF}/html"
	dosym ../../../doc/${PF}/html  /usr/share/gtk-doc/html/${PN}
}
