# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="training program to log physical activities of athletes"
HOMEPAGE="https://kipina.sourceforge.net"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-libs/libxml2
	dev-libs/libxslt
	gnome-base/libglade
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

# TODO: Condense using default_src_install
src_install() {
	emake DESTDIR="${D}" install
	emake -C doc/reference DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README TODO
	mv "${D}/usr/share/gtk-doc/html/${PN}" "${D}/usr/share/doc/${PF}/html"
	dosym ../../../doc/${PF}/html  /usr/share/gtk-doc/html/${PN}
}
