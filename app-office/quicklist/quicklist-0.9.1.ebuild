# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit gnome2 eutils autotools

DESCRIPTION="make quick lists of things in GNOME"
HOMEPAGE="http://quicklist.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	x11-libs/gtk+extra:2
	gnome-base/libgnomeprint:2.2
	gnome-base/libgnomeprintui:2.2
	gnome-extra/gtkhtml:3.14"
RDEPEND="${DEPEND}"

src_prepare() {
	default_src_prepare
	# Printing relies on functionality that was removed from gtkhtml in 2007
	epatch "${FILESDIR}/help.patch" "${FILESDIR}/report.patch" \
		"${FILESDIR}/fix_deps.patch" \
		"${FILESDIR}/remove_print_support.patch"
	eautoreconf
}

src_configure() {
	econf --disable-error-on-warning
}

src_install() {
	dodir /usr/share/doc/${PF}
	dosym ${PF} /usr/share/doc/${PN}
	gnome2_src_install -j1
	rm -f "${D}/usr/share/doc/${PN}"
#	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
