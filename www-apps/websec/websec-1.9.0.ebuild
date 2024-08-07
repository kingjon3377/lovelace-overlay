# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Web Secretary monitoring web pages for changes"
HOMEPAGE="https://savannah.nongnu.org/projects/websec https://github.com/baruch/websec"
SRC_URI="https://savannah.nongnu.org/download/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"

RDEPEND="dev-perl/libwww-perl"

src_prepare() {
	cp "${FILESDIR}/Makefile" "${S}"
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" DOCDIR="${D}/usr/share/doc/${PF}" \
		VIMSYNDIR="${D}/usr/share/vim/vimfiles/syntax" install
}

pkg_postinst() {
	einfo "See /usr/share/doc/${PF}/examples/ for configuration."
}
