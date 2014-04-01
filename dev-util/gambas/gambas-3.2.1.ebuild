# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-2.16.0.ebuild,v 1.3 2010/02/10 22:09:36 ssuominen Exp $

EAPI=5

inherit autotools eutils fdo-mime qt4-r2 multilib toolchain-funcs

DESCRIPTION="Gambas is a free development environment based on a Basic interpreter with object extensions"
HOMEPAGE="http://gambas.sourceforge.net/"

SLOT="3"
MY_PN="${PN}${SLOT}"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="
	+bzip2 +curl debug +doc +examples firebird +gtk mysql odbc +opengl +pcre
	+pdf postgres +qt4 +sdl smtp sqlite +sqlite3 +svg v4l +xml +zlib +imageio
	imlib
"

# Probably missing some Qt4 deps, as it says "All Qt 4 libraries >= Qt 4.5"
COMMON_DEPEND="
	bzip2?	( app-arch/bzip2 )
	curl?	( net-misc/curl )
	firebird?	( dev-libs/ibpp )
	gtk?	(
		x11-libs/gtk+:2
		x11-libs/cairo
	)
	imageio? ( x11-libs/gdk-pixbuf:2 )
	imlib? ( media-libs/imlib )
	mysql?	( >=virtual/mysql-5.0 )
	odbc?	( dev-db/unixODBC )
	opengl?	(
		media-libs/mesa
		media-libs/glew
		virtual/glu
	)
	pcre?	( dev-libs/libpcre:3 )
	pdf?	( app-text/poppler )
	postgres?	( dev-db/postgresql-base )
	qt4? (
		dev-qt/qtgui:4
		dev-qt/qtwebkit:4
		dev-qt/qtcore:4
		dev-qt/qtopengl:4
	)
	sdl?	(
		>=media-libs/sdl-image-1.2.6-r1
		>=media-libs/sdl-mixer-1.2.7
	)
	sqlite?	( dev-db/sqlite:0 )
	sqlite3?	( dev-db/sqlite:3 )
	v4l?	(
		media-libs/libpng
		virtual/jpeg
	)
	xml?	(
		dev-libs/libxml2:2
		dev-libs/libxslt
	)
	zlib?	( sys-libs/zlib )
	x11-libs/libXtst
	virtual/libffi
"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"

RDEPEND="${COMMON_DEPEND}"

S=${WORKDIR}/${MY_P}

REQUIRED_USE="pdf? ( || ( qt4 gtk sdl ) ) v4l? ( || ( qt4 gtk sdl ) )"
REQUIRED_USE="${REQUIRED_USE} opengl? ( || ( qt4 sdl ) )"

pkg_setup() {
	if ! use qt4; then
		einfo
		ewarn "The Gambas IDE currently cannot be be build without Qt being enabled."
		if use gtk; then
			einfo
			ewarn "You are using the USE flag gtk, but not qt4.  Attempting to use GTK instead"
			ewarn "of Qt for certain components.  This is considered EXPERIMENTAL and the"
			ewarn "resulting components may not function."
		fi
		einfo
		ebeep 3
	fi
}

my_reduce_eautoreconf() {
	sed -i -e "/^\(AC\|GB\)_CONFIG_SUBDIRS(${1}[,)]/d" \
	configure.ac \
	|| die "my_reduce_eautoreconf: sed on configure.ac failed with ${1}"

	sed -i -e "/^SUBDIRS/s/\ \(@${1}_dir@\|${1}\)//1" \
	Makefile.am \
	|| die "my_reduce_eautoreconf: sed on Makefile.am failed with ${1}"
}

my_examine_components() {
	local comp="gb.*/src/*.component gb.*/src/*/*.component main/lib/*/*.component comp/src/*/.component"

	# Examine app/src/gambas2/CComponent.class for more info
	echo
	einfo "Checking component files ..."
	einfo
	elog "The following components are reported stable, but incomplete:"
	elog "$(grep '^State=1' ${comp} | sed -e 's/.*\(gb\.[^/]*\)[/]\?\.component.*/\1/')"
	einfo
	ewarn "The following components are reported unstable:"
	ewarn "$(grep '^\(State=2\|Alpha\)' ${comp} | sed -e 's/.*\(gb\.[^/]*\)[/]\?\.component.*/\1/')"
	echo
}

src_prepare() {
	if { ! use qt4; } && use gtk; then
		ebegin "Applying sed no-Qt-use-GTK-workaround-patch (EXPERIMENTAL)"
		# Gentoo-specific patch/workaround
		sed -i -e 's/EXPORT = "gb.qt"/EXPORT = "gb.gtk"/' \
			main/lib/gui/main.c \
			|| die "sed no-Qt-use-GTK-workaround-patch (EXPERIMENTAL)"
		eend 0
	fi

	ebegin "Applying sed no-automagic-patch"
	# Gentoo-specific patch
	sed -i -e 's/gb_enable_\$1=yes/gb_enable_\$1=no/' \
		acinclude.m4 \
		|| die "sed no-automagic-patch failed"
	eend 0

	# Gentoo-specific patches for libtool compatibility
	epatch "${FILESDIR}/${PN}-2.8.0-libtool.patch"

	# Gentoo-specific patch
	epatch "${FILESDIR}/${PN}-3.0.0-FLAGS.patch"

	# Replacement for Gentoo-specific gambas-2.5.0-mimetype-registration.patch
	# submitted upstream
#	epatch "${FILESDIR}/svn-r1636-xdg-utils.patch"

#	epatch "${FILESDIR}/${PN}-2.9.0-app_Makefile.am.patch"
#	epatch "${FILESDIR}/${PN}-2.9.0-comp_Makefile.am.patch"
#	epatch "${FILESDIR}/${PN}-2.9.0-examples_Makefile.am.patch"
#	epatch "${FILESDIR}/${PN}-2.9.0-help_Makefile.am.patch"
#	epatch "${FILESDIR}/${PN}-2.9.0-main_Makefile.am.patch"
#	epatch "${FILESDIR}/${PN}-2.9.0-component.am.patch"

	ebegin "Applying sed remove-dist_gblib_DATA-patch"
	# Prevent repeat installation of component files
	sed -i -e '/^dist_gblib_DATA/d' \
		component.am \
		main/lib/Makefile.am \
		|| die "sed remove-dist_gblib_DATA-patch failed"
	eend 0

	ebegin "Applying sed remove-libtool-patch"
	# Gentoo-specific patch, may be obsoleted in the future
	# Remove embedded libtool.m4 file
	sed -i -e '/[-][*][-]Autoconf[-][*][-]$/,$d' \
		acinclude.m4 \
		|| die "sed remove-libtool-patch failed"
	eend 0

	my_examine_components

	ebegin "Removing provided libtool/libltdl"
	rm config.guess config.sub install-sh \
		&& rm */config.guess */config.sub */install-sh \
		|| die "removing libtool failed"
		eend 0

	sed -i -e ':x; /\\$/ { N; s/\\\n//; tx }' Makefile.am || \
		die "fixing Makefile.am for my_reduce_eautoreconf failed"

	ebegin "Reducing eautoreconf"
	# Keep synchronized with myconf in src_compile
	use bzip2 ||	my_reduce_eautoreconf bzlib2
	use zlib ||	my_reduce_eautoreconf zlib
	use mysql ||	my_reduce_eautoreconf mysql
	use odbc ||	my_reduce_eautoreconf odbc
	use postgres ||	my_reduce_eautoreconf postgresql
	use sqlite ||	my_reduce_eautoreconf sqlite2
	use sqlite3 ||	my_reduce_eautoreconf sqlite3
	use firebird ||	my_reduce_eautoreconf firebird
	use gtk ||	my_reduce_eautoreconf gtk
	use svg ||	my_reduce_eautoreconf gtksvg
	use pdf ||	my_reduce_eautoreconf pdf
			#net
	use curl ||	my_reduce_eautoreconf curl
	use smtp ||	my_reduce_eautoreconf smtp
	use pcre ||	my_reduce_eautoreconf pcre
	use qt4 ||	my_reduce_eautoreconf qt
			my_reduce_eautoreconf qte
	my_reduce_eautoreconf kde
	use sdl ||	my_reduce_eautoreconf sdl
	use sdl ||	my_reduce_eautoreconf sdlsound
	use xml ||	my_reduce_eautoreconf xml
	use v4l ||	my_reduce_eautoreconf v4l
			#crypt
	use opengl ||	my_reduce_eautoreconf opengl
#	use corba ||	my_reduce_eautoreconf corba
	{ use qt4 || use gtk || \
	use sdl; } ||	my_reduce_eautoreconf image
	use qt4 ||	my_reduce_eautoreconf desktop
	# This may work in the future, but it does not work now.
#	{ use qt4 || \
#	use gtk; } ||	my_reduce_eautoreconf desktop

	use doc ||	my_reduce_eautoreconf help
	use examples ||	my_reduce_eautoreconf examples
	eend 0

	sed -i \
		-e "s:xdg-icon-resource install:\\0 --mode user:" \
		-e "s:xdg-mime install:\\0 --mode user:" \
		main/Makefile.am app/Makefile.am

	eautoreconf
}

src_configure() {
	local myconf="
		$(use_enable bzip2 bzlib2)
		$(use_enable zlib)
		$(use_enable mysql)
		$(use_enable odbc)
		$(use_enable postgres postgresql)
		$(use_enable sqlite sqlite2)
		$(use_enable sqlite3)
		$(use_enable firebird)
		$(use_enable gtk)
		$(use_enable svg gtksvg)
		$(use_enable pdf)
		--enable-net
		$(use_enable curl)
		$(use_enable smtp)
		$(use_enable pcre)
		$(use_enable qt4 qt)
		$(use_enable qt4 qt4)
		--disable-qte
		--disable-kde
		$(use_enable sdl)
		$(use_enable sdl sdlsound)
		$(use_enable xml)
		$(use_enable v4l)
		--enable-crypt
		$(use_enable opengl)
		--disable-corba
		$( { use qt4 || use gtk || use sdl; } \
		&& echo '--enable-image' || echo '--disable-image')
		$(use_enable qt4 desktop)
	"
		# This may work in the future, but it does not work now.
#		$( { use qt4 || use gtk; } && echo '--enable-desktop' || echo '--disable-desktop')"

	myconf="${myconf}
		--enable-intl
		--enable-conv
		--enable-ffi
		--enable-preloading
		--disable-profiling
		$(use_enable debug)
		$(use_enable xml xslt)
	"
	if use qt4; then
		myconf="${myconf}
			$(use_enable opengl qtopengl)
			--enable-qt-translation
		"
	fi

	# --without-xdg-utils comes from svn-r1636-xdg-utils.patch
	econf --config-cache ${myconf} --without-xdg-utils \
	--docdir=/usr/share/doc/${PF} --htmldir=/usr/share/doc/${PF}/html
}

my_dekstop_and_icon() {
	# USAGE: <executable> <name> <category> <icon_source_file> <icon_target_dir>
	local icon="${1}.png"

	make_desktop_entry "${1}" "${2}" "${5}/${icon}" "${3}"

	insinto ${5}
	newins ${4} ${icon}
}

src_compile() {
	emake LIBTOOLFLAGS="--quiet"
}

src_install() {
	emake DESTDIR="${D}" LIBTOOLFLAGS="--quiet" install

	dodoc AUTHORS ChangeLog NEWS README
	newdoc gb.net/src/doc/README gb.net-README
	newdoc gb.net/src/doc/changes.txt gb.net-ChangeLog
	use pcre && newdoc gb.pcre/src/README gb.pcre-README

	if { use qt4 || use gtk; } ; then
		# Remove qt4 test when it works without it
		use qt4 && \
		my_dekstop_and_icon \
		"${MY_PN}" "Gambas" "Development" \
		"app/src/${MY_PN}/img/logo/logo.png" \
		"/usr/share/icons/hicolor/128x128/apps"

		insinto /usr/share/icons/hicolor/64x64/mimetypes
		doins app/mime/*.png main/mime/*.png

		insinto /usr/share/mime/application
		doins app/mime/*.xml main/mime/*.xml
	fi

#	use doc && dosym "../doc/${PF}/html" "/usr/share/${MY_PN}/help"
}

my_fdo_update() {
	{ use qt4 || use gtk; } && fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postinst() {
	my_fdo_update
}

pkg_postrm() {
	my_fdo_update
}
