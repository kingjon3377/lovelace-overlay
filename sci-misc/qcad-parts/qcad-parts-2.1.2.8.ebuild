# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/qcad-parts/qcad-parts-2.0.1.2-r1.ebuild,v 1.5 2006/11/05 23:37:54 jer Exp $

EAPI=5

MY_PN="partlibrary"
MY_PV="${PV}-1"

DESCRIPTION="Collection of CAD files that can be used from the library browser of QCad"
LICENSE="GPL-2"
HOMEPAGE="http://www.ribbonsoft.com/qcad_library.html"
SRC_URI="ftp://anonymous:anonymous@ribbonsoft.com/archives/${MY_PN}/${MY_PN}-${MY_PV}.zip"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="sci-misc/qcad"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

src_install() {
	einfo "Fixing permissions - this might take a while"
	insinto /usr/share/${PN}
	doins -r ./*
}

pkg_postinst() {
	einfo
	einfo "The QCad parts library was installed in"
	einfo "/usr/share/${PN}"
	einfo "Please set this path in QCad's preferences to access it."
	einfo "(Edit->Application Preferences->Paths->Part Libraries)"
	einfo
	einfo "After restarting QCad, you can use the library by selecting"
	einfo "View->Views->Library Browser"
	einfo
}
