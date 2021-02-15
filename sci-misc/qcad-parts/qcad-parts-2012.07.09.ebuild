# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit readme.gentoo-r1

DESCRIPTION="Collection of CAD files that can be used from the library browser of QCad"
LICENSE="GPL-2"
HOMEPAGE="https://www.ribbonsoft.com/en/qcad-add-ons"
URI_BASE="https://www.ribbonsoft.com/archives/partlibrary/"
URI_DATE=$(ver_rs 1- -)
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
# TODO: There are a few more now, but the old ones still have their old dates.
# Should we "version bump," split the package, or what?
IUSE="+architecture +electronics +gis +hydraulics +circuits +mechanics +misc +processing +nounproject"
REQUIRED_USE="|| ( architecture electronics gis hydraulics circuits mechanics misc processing nounproject )"

DEPEND="app-arch/unzip"
RDEPEND="sci-misc/qcad"

S="${WORKDIR}"

DOC_CONTENTS="
The QCad parts library was installed in
/usr/share/${PN}
Please set this path in QCad's preferences to access it.
(Edit->Application Preferences->Paths->Part Libraries)

After restarting QCad, you can use the library by selecting
View->Views->Library Browser
"

src_install() {
	insinto /usr/share/${PN}
	doins -r ./*
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
