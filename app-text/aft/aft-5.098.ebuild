# Copyright 1999-2011 Gentoo Foundation
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
	dodoc AUTHORS ChangeLog NEWS README debian/copyright debian/README.Debian
	doman debian/${PN}.1
	ewarn "This package includes a Vim plugin, which this ebuild ignores."
	ewarn "This package installs Perl modules in a nonstandard location."
}
