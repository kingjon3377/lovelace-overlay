# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Copyright 2002 Paul Thompson

EAPI=5

inherit gnome2 eutils

# This may be a little fragile; I was able to make it import savings bond wizard
# format, read and write its own xml format, and download treasury databases. I
# also could crash it.

DESCRIPTION="A GNOME US savings bonds inventory program."
HOMEPAGE="http://www.snaught.com/gbonds"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://debian/pool/main/g/${PN}/${PN}_${PV}-2.1.debian.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="nls"
KEYWORDS="x86 amd64"

# Some of these are pulled from the home page claims, the rest are ripped from
# the libraries the program is linked against. Some may be redundant.
DEPEND="x11-libs/gtk+:2
		dev-libs/libxml2:2
		gnome-base/libgnomeprintui:2.2
		gnome-base/gnome-vfs:2
		nls? ( sys-devel/gettext )
		x11-base/xorg-x11
		gnome-base/libgnomeui
		gnome-base/libbonobo"
RDEPEND="${DEPEND}"

src_prepare() {
	for patch in $(cat "${WORKDIR}/debian/patches/series"); do
		epatch "${WORKDIR}/debian/patches/${patch}"
	done
}

src_configure() {
	local myconf=""
	use nls || myconf="--disable-nls"
	econf ${myconf} UPDATE_DESKTOP_DATABASE=/bin/true UPDATE_MIME_DATABASE=/bin/true
}

src_install () {
	gnome2_src_install
	dodoc AUTHORS ChangeLog NEWS README
	dosym /usr/share/gnome/help/gbonds/C /usr/share/doc/${PF}/html
	cd ../debian
	doman gbonds.1
	dodir /usr/share/gbonds
	insinto /usr/share/gbonds
	doins sb*.asc
}
