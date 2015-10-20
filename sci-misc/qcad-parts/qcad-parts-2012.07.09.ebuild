# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit versionator

DESCRIPTION="Collection of CAD files that can be used from the library browser of QCad"
LICENSE="GPL-2"
HOMEPAGE="http://www.ribbonsoft.com/en/qcad-add-ons"
URI_BASE="http://www.ribbonsoft.com/archives/partlibrary/"
URI_DATE=$(replace_all_version_separators -)
create_uri() {
	echo "${URI_BASE}${1}-${URI_DATE}.zip"
}
SRC_URI="architecture? ( $(create_uri Architecture) )
	electronics? ( $(create_uri Electronics) )
	gis? ( $(create_uri GIS) )
	hydraulics? ( $(create_uri Hydraulics) )
	circuits? ( ${URI_BASE}LRMCircuits-2014-02-05.zip )
	mechanics? ( $(create_uri Mechanics) )
	misc? ( $(create_uri Misc) )
	processing? ( $(create_uri Processing) )
	nounproject? ( $(create_uri thenounproject.com) )"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+architecture +electronics +gis +hydraulics +circuits +mechanics +misc +processing +nounproject"
REQUIRED_USE="|| ( architecture electronics gis hydraulics circuits mechanics misc processing nounproject )"

DEPEND="app-arch/unzip"
RDEPEND="sci-misc/qcad"

S="${WORKDIR}"

src_install() {
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
