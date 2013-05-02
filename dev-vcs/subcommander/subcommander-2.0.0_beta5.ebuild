# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils libtool qt4-r2 fdo-mime autotools toolchain-funcs

DESCRIPTION="QT based cross-platform Subversion client, diff & merge tool."
HOMEPAGE="http://subcommander.tigris.org/"
SRC_URI="http://subcommander.tigris.org/files/documents/1759/47637/${PN/s/S}-${PV/_beta/b}p2.tar.gz
	mirror://debian/pool/main/s/${PN}/${PN}_${PV/_beta/~b}p2-5.debian.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=dev-libs/boost-1.32
	>=dev-vcs/subversion-1.2
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-libs/apr:1
	sys-libs/db:4.8
	dev-qt/qt3support:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}-${PV/_beta/b}

src_prepare() {
#	sed -i -e 's:71,7:58,7:g' \
#		"${WORKDIR}"/debian/patches/95_warnings.patch || die "fixing patch failed"
	rm "${WORKDIR}"/debian/patches/71-dont-require-svn.patch || die "removing unwanted patch failed"
	epatch "${WORKDIR}"/debian/patches/*patch
	sed -i -e 's:include/Qt:include/qt4:' \
		-e 's:QT_LIBPATH="$qt_path/lib":QT_LIBPATH="$qt_path/lib/qt4":' \
		"${S}/configure.ac" || die "fixing configure failed"
	sed -i -e \
		's:/usr/share/xml/docbook/stylesheet/nwalsh/html/chunk.xsl:/usr/share/sgml/docbook/xsl-stylesheets/html/chunk.xsl:g' \
		doc/docbook/guide/Makefile || die "fixing doc stylesheet reference failed"
	eautoreconf
}

src_compile() {
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" CXXFLAGS="${CXXFLAGS}"
	emake -C po CC=$(tc-getCC) CXX=$(tc-getCXX) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" CXXFLAGS="${CXXFLAGS}"
	emake -C doc/docbook/guide CC=$(tc-getCC) CXX=$(tc-getCXX) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" CXXFLAGS="${CXXFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install

	doicon pics/subcommander.png
	make_desktop_entry subcommander "Subcommander ${PV}" \
		"/usr/share/pixmaps/subcommander.png" \
		"Programming;Development;RevisionControl"
	emake DESTDIR="${D}" install -C po
	emake DESTDIR="${D}"/usr/share/doc/${P}/html -C doc/docbook/guide install
	dodoc CHANGES README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
