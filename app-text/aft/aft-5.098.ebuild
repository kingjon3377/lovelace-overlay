# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="\"free form\" document preparation system"
HOMEPAGE="http://www.maplefish.com/todd/aft.html"
SRC_URI="http://www.maplefish.com/todd/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/aft_5.097-1.diff
}

src_install() {
	emake DESTDIR="${D}" install
	mv -i "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${PF}"
	rm "${D}/usr/share/${PN}/${PN}.pl" "${D}/usr/share/${PN}/launch_ie.pl"
	dodoc AUTHORS ChangeLog NEWS README "${FILESDIR}/README.Debian" "${FILESDIR}/${PN}.sl"
	docinto vim
	newdoc "${FILESDIR}/${PN}rc.vim" ${PN}rc
	newdoc "${FILESDIR}/README.vim" README
	newdoc "${FILESDIR}/no${PN}rc.vim" no${PN}rc
	dodoc syntax-demo.aft ${PN}.vim
	doman "${FILESDIR}/${PN}.1"
	ewarn "This package installs Perl modules in a nonstandard location."
}
