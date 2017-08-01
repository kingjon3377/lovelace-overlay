# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Displays relative 3-dimensional positions of stars in space."
HOMEPAGE="http://www.starplot.org"
SRC_URI="http://starplot.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

DEPEND="x11-libs/gtk+:2
		dev-cpp/gtkmm:2.4"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/*.dpatch
}

src_install () {
	emake DESTDIR="${D}" install
	mv -i "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${P}" || die "renaming doc dir failed"
	dodir /usr/share/pixmaps
	insinto /usr/share/pixmaps
	doins src/gui/*.xpm
	dohtml -r doc/html
	dodoc ChangeLog AUTHORS NEWS NLS-TEAM README TODO "${FILESDIR}/README.source"
	dodir /usr/$(get_libdir)/stardata
	insinto /usr/$(get_libdir)/stardata
	newins "${FILESDIR}/${PN}.sh" ${PN}
	dodir /usr/share/${PN}/specfiles
	insinto /usr/share/${PN}/specfiles
	doins "${FILESDIR}"/*.spec
}
