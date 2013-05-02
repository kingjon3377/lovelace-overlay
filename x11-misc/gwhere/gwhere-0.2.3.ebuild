# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# From bug #289079

EAPI=5

inherit eutils flag-o-matic autotools

DESCRIPTION="Removable media cataloger made with GTK+"
HOMEPAGE="http://www.gwhere.org/"
SRC_URI="http://www.gwhere.org/download/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	x11-libs/libXi
	x11-libs/libXext
	x11-libs/libX11
	sys-libs/zlib
	x11-libs/libXau
	x11-libs/libXdmcp
	"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}.diff" "${FILESDIR}/datarootdir.patch" "${FILESDIR}/missing_separator.patch"
	ln -s /usr/share/gettext/config.rpath .
	eautoreconf
}

src_configure() {
	use amd64 && append-flags "-Wall -fPIC -fPIE"
	use amd64 && append-ldflags "-Wl,-pie"
	use amd64 && filter-flags -fomit-frame-pointer
	econf --enable-gtk20
}

src_install() {
	# einstall is needed here
	einstall
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
	dodir /usr/$(get_libdir)/gwhere/plugins
	dodir /usr/$(get_libdir)/gwhere/plugins/catalog
	dodir /usr/$(get_libdir)/gwhere/plugins/descr
	dosym ../../../libgwplugincatalogcsv.a /usr/$(get_libdir)/gwhere/plugins/catalog/
	dosym ../../../libgwplugincatalogcsv.la /usr/$(get_libdir)/gwhere/plugins/catalog/
	dosym ../../../libgwplugincatalogcsv.so /usr/$(get_libdir)/gwhere/plugins/catalog/
	dosym ../../../libgwplugincatalogcsv.so.1 /usr/$(get_libdir)/gwhere/plugins/catalog/
	dosym ../../../libgwplugincatalogcsv.so.1.0.0 /usr/$(get_libdir)/gwhere/plugins/catalog/
	dosym ../../../libgwplugincataloggwcatalog.a /usr/$(get_libdir)/gwhere/plugins/catalog/
	dosym ../../../libgwplugincataloggwcatalog.la /usr/$(get_libdir)/gwhere/plugins/catalog/
	dosym ../../../libgwplugincataloggwcatalog.so /usr/$(get_libdir)/gwhere/plugins/catalog/
	dosym ../../../libgwplugincataloggwcatalog.so.1 /usr/$(get_libdir)/gwhere/plugins/catalog/
	dosym ../../../libgwplugincataloggwcatalog.so.1.0.0 /usr/$(get_libdir)/gwhere/plugins/catalog/
	dosym ../../../libgwplugindescriptionavi.a /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionavi.la /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionavi.so /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionavi.so.1 /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionavi.so.1.0.0 /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptiondescript_ion.a /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptiondescript_ion.la /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptiondescript_ion.so /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptiondescript_ion.so.1 /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptiondescript_ion.so.1.0.0 /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionfile_id_diz.a /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionfile_id_diz.la /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionfile_id_diz.so /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionfile_id_diz.so.1 /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionfile_id_diz.so.1.0.0 /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionhtml.a /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionhtml.la /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionhtml.so /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionhtml.so.1 /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionhtml.so.1.0.0 /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionmp3.a /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionmp3.la /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionmp3.so /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionmp3.so.1 /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionmp3.so.1.0.0 /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionmpc.a /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionmpc.la /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionmpc.so /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionmpc.so.1 /usr/$(get_libdir)/gwhere/plugins/descr/
	dosym ../../../libgwplugindescriptionmpc.so.1.0.0 /usr/$(get_libdir)/gwhere/plugins/descr/
}

pkg_postinst() {
	ewarn "This package installs a lot of static archives and libtool archives"
	ewarn "with 'plugin' in their names; are they really needed?"
}
