# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils fdo-mime qt4-r2 multilib libtool

DESCRIPTION="Gambas is a free development environment based on a Basic interpreter with object extensions"
HOMEPAGE="http://gambas.sourceforge.net/"

SLOT="3"
MY_PN="${PN}${SLOT}"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="
	+bzip2 cairo crypt +curl dbus desktop +examples gsl +gtk +imageio imageimlib \
	jit +media mysql mime +ncurses net +opengl postgres odbc +pcre +pdf \
	+qt4 +sdl +sdlsound smtp sqlite +sqlite3 +svg v4l +xml +zlib"
# doc

COMMON_DEPEND="
	bzip2?	( app-arch/bzip2 )
	cairo?	( x11-libs/cairo )
	curl?	( net-misc/curl )
	desktop?	( x11-libs/libXtst )
	gsl?	( sci-libs/gsl )
	gtk?	(
		x11-libs/gtk+:2
		x11-libs/cairo
		svg? ( gnome-base/librsvg:2 )
	)
	imageio? ( x11-libs/gdk-pixbuf:2 )
	imageimlib?	( media-libs/imlib2 )
	jit?	( >=sys-devel/llvm-3.1 )
	media?	( media-libs/gstreamer )
	mysql?	( >=virtual/mysql-5.0 )
	mime?	( dev-libs/gmime:2.4 )
	ncurses? ( sys-libs/ncurses )
	net? ( >=net-misc/curl-7.13 )
	odbc?	( dev-db/unixODBC )
	opengl?	(
		media-libs/mesa
		media-libs/glew
		virtual/glu
	)
	pcre?	( dev-libs/libpcre:3 )
	pdf?	( app-text/poppler )
	postgres?	( dev-db/postgresql )
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
	sdlsound?	( media-libs/sdl-sound )
	smtp?	( dev-libs/glib:2 )
	svg?	( gnome-base/librsvg )
	v4l?	(
		media-libs/libpng
		virtual/jpeg
	)
	xml?	(
		dev-libs/libxml2:2
		dev-libs/libxslt
	)
	zlib?	( sys-libs/zlib )
	virtual/libffi
"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"

RDEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/${PN}3-${PV}"

src_prepare() {
	epatch "${FILESDIR}/xdgutils.patch"
	elibtoolize
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable bzip2 bzlib2) \
		$(use_enable zlib) \
		$(use_enable mysql) \
		$(use_enable odbc) \
		$(use_enable postgres postgresql) \
		$(use_enable sqlite sqlite2) \
		$(use_enable sqlite3) \
		$(use_enable net) \
		$(use_enable curl) \
		$(use_enable smtp) \
		$(use_enable mime) \
		$(use_enable pcre) \
		$(use_enable sdl) \
		$(use_enable sdlsound) \
		$(use_enable xml libxml) \
		$(use_enable xml) \
		$(use_enable v4l) \
		$(use_enable crypt) \
		$(use_enable qt4) \
		$(use_enable gtk) \
		$(use_enable opengl) \
		$(use_enable desktop) \
		$(use_enable pdf) \
		$(use_enable cairo) \
		$(use_enable imageio) \
		$(use_enable imageimlib) \
		$(use_enable dbus) \
		$(use_enable gsl) \
		$(use_enable ncurses) \
		$(use_enable media) \
		$(use_enable jit)
}

#src_compile() {
#	emake LIBTOOLFLAGS="--quiet"
#}

src_install() {
	DESTDIR="${D}" make install

	svn log > ChangeLog
	dodoc AUTHORS ChangeLog README
	use net && newdoc gb.net/src/doc/README gb.net-README
	use net && newdoc gb.net/src/doc/changes.txt gb.net-ChangeLog
	use pcre && newdoc gb.pcre/src/README gb.pcre-README
	use sqlite && newdoc gb.db.sqlite2/README gb.db.squlite2-README
	use sqlite3 && newdoc gb.db.sqlite3/README gb.db.sqlite3-README
	use jit && newdoc gb.jit/README gb.jit-README
	use smtp && newdoc gb.net.smtp/README gb.net.smtp-README

	if { use qt4 || use gtk; } ; then
		insinto /usr/share/applications
		doins app/desktop/gambas3.desktop
		insinto /usr/share/icons/hicolor/128x128/apps
		newins app/src/${PN}3/img/logo/logo.png gambas3.png

		insinto /usr/share/icons/hicolor/64x64/mimetypes
		doins app/mime/*.png main/mime/*.png

		insinto /usr/share/mime/application
		doins app/mime/*.xml main/mime/*.xml
	fi
}

my_fdo_update() {
	{ use qt4 || use gtk; } && fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_preinst() {
	libtool --finish "${D}/usr/lib64/gambas3" || die "finish failed"
}

pkg_postinst() {
	my_fdo_update
}

pkg_postrm() {
	my_fdo_update
}
