# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# TODO: Do we really still need eutils?
inherit eutils

DESCRIPTION="Displays relative 3-dimensional positions of stars in space."
HOMEPAGE="http://www.starplot.org"
SRC_URI="http://starplot.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:2
		dev-cpp/gtkmm:2.4"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/01-starplot_desktop_file.diff"
	"${FILESDIR}/02-fix-ftbfs-and-hrdiagram-opts.diff"
	"${FILESDIR}/03-fix-ftbfs-convert.diff"
	"${FILESDIR}/04-fix-ftbfs-strings.diff"
	"${FILESDIR}/05-startup-crash.diff"
)

src_install () {
	emake DESTDIR="${D}" install
	dodir /usr/share/pixmaps
	insinto /usr/share/pixmaps
	doins src/gui/*.xpm
	dodoc ChangeLog AUTHORS NEWS NLS-TEAM README TODO "${FILESDIR}/README.source"
	dodoc -r doc/html
	dodir /usr/$(get_libdir)/stardata
	insinto /usr/$(get_libdir)/stardata
	newins "${FILESDIR}/${PN}.sh" ${PN}
	dodir /usr/share/${PN}/specfiles
	insinto /usr/share/${PN}/specfiles
	doins "${FILESDIR}"/*.spec
}
