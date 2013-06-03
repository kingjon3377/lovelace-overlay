# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib

MY_P="ats-lang-anairiats-${PV}"

DESCRIPTION="ATS language compiler"
HOMEPAGE="http://www.ats-lang.org"
SRC_URI="mirror://sourceforge/ats-lang/ats-lang/anairiats-${PV}/${MY_P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-libs/gmp"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf
	sed -i -e "s:lib:$(get_libdir):" config.mk
}

src_compile() {
	emake -j1 all
}

src_install() {
	default
	mv "${D}/usr/$(get_libdir)/${PN}-anairiats-${PV}/doc" "${D}/usr/share/doc/${P}"
	mv "${D}/usr/$(get_libdir)/${PN}-anairiats-${PV}/VERSION.txt" "${D}/usr/share/doc/${P}/"
	rm "${D}/usr/$(get_libdir)/${PN}-anairiats-${PV}/INSTALL"
}

pkg_postinst() {
	ewarn "I've ignored a bunch of 'recommended' (optional automagical) deps;"
	ewarn "these amount to 'contrib' stuff installed heedless of dependencies."
}
