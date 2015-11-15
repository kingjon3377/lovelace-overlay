# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils

DESCRIPTION="Timeline calendar with immense zooming"
HOMEPAGE="http://calizo.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PN/c/C}-${PV}/${P}_src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
LANGS=( de ru )
for lang in "${LANGS[@]}"; do
	IUSE="${IUSE} linguas_${lang}"
done

RDEPEND="x11-libs/wxGTK:2.8"
DEPEND="${DEPEND}
	app-arch/unzip"

S="${WORKDIR}/${PN}"

src_prepare() {
	eautoreconf
	gunzip ubuntu_installer/debian/usr/share/man/man1/${PN}.1.gz
}

src_install() {
	default
	newicon artworks/icon.png ${PN}.png
	for lang in "${LANGS[@]}"; do
		if use linguas_${lang}; then
			insinto /usr/share/locale/${lang}/LC_MESSAGES
			doins i18n/locale/${lang}/${PN}.mo
		fi
	done
	dodoc help/help/${PN}.htb
	dodoc help/help_${PN}.pdf
	insinto /usr/share/applications
	doins ubuntu_installer/debian/usr/share/applications/${PN}.desktop
	doman ubuntu_installer/debian/usr/share/man/man1/${PN}.1
}
