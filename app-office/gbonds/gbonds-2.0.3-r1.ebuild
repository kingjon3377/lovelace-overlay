# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Copyright 2002 Paul Thompson

EAPI=6

inherit gnome2 autotools

# This may be a little fragile; I (original ebuild author) was able to make it
# import savings bond wizard format, read and write its own xml format, and
# download treasury databases. I also could crash it.

DESCRIPTION="A GNOME US savings bonds inventory program."
HOMEPAGE="http://www.snaught.com/gbonds"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://debian/pool/main/g/${PN}/${PN}_${PV}-11.debian.tar.xz"

LICENSE="GPL-2"
SLOT="0"
IUSE="nls"
KEYWORDS="~x86 ~amd64"

# Some of these are pulled from the home page claims, the rest are ripped from
# the libraries the program is linked against. Some may be redundant.
RDEPEND="x11-libs/gtk+:2
		dev-libs/libxml2:2
		gnome-base/gnome-vfs:2
		nls? ( sys-devel/gettext )
		x11-base/xorg-x11
		gnome-base/libgnomeui
		gnome-base/libbonobo"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

src_prepare() {
	for patch in $(cat "${WORKDIR}/debian/patches/series"); do
		eapply "${WORKDIR}/debian/patches/${patch}"
	done
	chmod 644 "${WORKDIR}/debian/"sb*.asc || die
	sed -i -e 's@^gbonds_LDADD =  \\$@gbonds_LDADD = -lm \\@' src/Makefile.am
	default
	eautoreconf
}

src_configure() {
	local myconf=""
	use nls || myconf="--disable-nls"
	econf ${myconf} UPDATE_DESKTOP_DATABASE=/bin/true UPDATE_MIME_DATABASE=/bin/true
}

src_install () {
	gnome2_src_install
	dodoc AUTHORS ChangeLog NEWS README
	dosym ../../gnome/help/gbonds/C /usr/share/doc/${PF}/html
	doman ../debian/${PN}.1
	dodir /usr/share/gbonds
	insinto /usr/share/gbonds
	doins ../debian/sb*.asc
}
