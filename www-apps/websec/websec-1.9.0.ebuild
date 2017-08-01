# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="A Web Secretary monitoring web pages for changes"
HOMEPAGE="http://baruch.ev-en.org/proj/websec/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86 amd64"
SLOT="0"

RDEPEND="dev-perl/libwww-perl"

src_prepare() {
	cp "${FILESDIR}/Makefile" "${S}"
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" DOCDIR="${D}/usr/share/doc/${PF}" \
		VIMSYNDIR="${D}/usr/share/vim/vimfiles/syntax" install
}

pkg_postinst() {
	einfo "See /usr/share/doc/${P}/examples/ for configuration."
}
