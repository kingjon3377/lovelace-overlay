# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Copyright 2002 Paul Thompson

EAPI=7

inherit gnome2 autotools

# This may be a little fragile; I (original ebuild author) was able to make it
# import savings bond wizard format, read and write its own xml format, and
# download treasury databases. I also could crash it.

DESCRIPTION="A GNOME US savings bonds inventory program."
HOMEPAGE="https://gbonds.sourceforge.net"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}.tar.gz
	mirror://debian/pool/main/g/${PN}/${PN}_${PV}-17.debian.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

# Libraries the Debian package depends on.
RDEPEND="x11-libs/gtk+:3
		dev-libs/libxml2:2
		x11-libs/cairo:0
		nls? ( sys-devel/gettext )
		x11-libs/gdk-pixbuf:2
		dev-libs/glib:2
		x11-libs/pango:0"
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
	insinto /usr/share/gbonds
	doins ../debian/sb*.asc
}
