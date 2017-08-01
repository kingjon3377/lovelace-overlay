# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools eutils fdo-mime libtool multilib qt4-r2

DESCRIPTION="A free IDE based on a Basic interpreter with object extensions"
HOMEPAGE="http://gambas.sourceforge.net/"

SLOT="3"
MY_PN="${PN}${SLOT}"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="
	+bzip2 +cairo crypt +curl dbus +desktop examples gmp gsl +gtk httpd +imageio imageimlib \
	jit +media mysql +mime +ncurses +net +opengl postgres odbc openssl openal +pcre +pdf \
	+qt4 +sdl +sdlsound smtp +sqlite +svg +v4l +xml +zlib"

REQUIRED_USE="gtk? ( cairo ) media? ( v4l ) mysql? ( zlib ) net? ( curl ) sdl? ( opengl ) xml? ( net ) net? ( mime )"

# libcrypt.so is part of glibc
# gtk? ( x11-libs/gtk+:2[cups] )
COMMON_DEPEND="
	bzip2?	( app-arch/bzip2 )
	cairo?	( x11-libs/cairo )
	curl?	( net-misc/curl )
	dbus?	( sys-apps/dbus )
	desktop?	(
		x11-libs/libXtst
		x11-misc/xdg-utils
		gnome-base/gnome-keyring
	)
	gmp?	( dev-libs/gmp:0 )
	gsl?	( sci-libs/gsl )
	gtk?	(
		x11-libs/gtk+:2
		svg? ( gnome-base/librsvg:2 )
		x11-libs/gtkglext
	)
	imageio? ( x11-libs/gdk-pixbuf:2 )
	imageimlib?	( media-libs/imlib2 )
	jit?	( >=sys-devel/llvm-3.1:0 )
	media?	(
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
		media-plugins/gst-plugins-xvideo
	)
	mysql?	( >=virtual/mysql-5.0 )
	mime?	( dev-libs/gmime:2.6 )
	ncurses? ( sys-libs/ncurses:0 )
	odbc?	( dev-db/unixODBC )
	openal? ( media-libs/alure )
	opengl?	(
		media-libs/mesa
		|| ( x11-libs/libGLw x11-drivers/nvidia-drivers )
		media-libs/glew:0
		virtual/glu
	)
	openssl?	( dev-libs/openssl:0 )
	pcre?	( dev-libs/libpcre:3 )
	pdf?	( app-text/poppler )
	postgres?	( dev-db/postgresql:= )
	qt4? (
		dev-qt/qtwebkit:4
		dev-qt/qtcore:4
		dev-qt/qtopengl:4
	)
	sdl?	(
		media-libs/sdl-image
		media-libs/sdl-mixer
		media-libs/sdl-ttf
	)
	sdlsound?	( media-libs/sdl-sound )
	smtp?	( dev-libs/glib:2 )
	sqlite?	( dev-db/sqlite:3 )
	svg?	( gnome-base/librsvg )
	v4l?	(
		media-tv/v4l-utils
		media-libs/libpng:0
		virtual/jpeg:0
	)
	xml?	(
		dev-libs/libxml2:2
		dev-libs/libxslt
	)
	zlib?	( sys-libs/zlib )
	x11-libs/libSM
	x11-libs/libXcursor
	virtual/libffi
"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"

RDEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/xdgutils.patch"
	sed -i -e 's:^\(gb_image_la_CFLAGS = -I\$(top_srcdir)/share \)\(\$(AM_CFLAGS)\)$:\1-lm \2:' \
		main/lib/image/Makefile.am || die
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
		$(use_enable sqlite sqlite3) \
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
		$(use_enable gmp) \
		$(use_enable ncurses) \
		$(use_enable media) \
		$(use_enable jit) \
		$(use_enable httpd) \
		$(use_enable openssl) \
		$(use_enable openal)
}

src_install() {
	DESTDIR="${D}" emake -j1 install # Sometimes fails with "file exists" errors.

	dodoc AUTHORS README TODO
	use net && newdoc gb.net/src/doc/README gb.net-README
	use net && newdoc gb.net/src/doc/changes.txt gb.net-ChangeLog
	use pcre && newdoc gb.pcre/src/README gb.pcre-README
	use sqlite && newdoc gb.db.sqlite3/README gb.db.sqlite3-README
	use jit && newdoc gb.jit/README gb.jit-README
	use smtp && newdoc gb.net.smtp/README gb.net.smtp-README

	if { use qt4 || use gtk; } ; then
		insinto /usr/share/applications
		doins app/desktop/gambas3.desktop

		newicon -s 128 app/src/${MY_PN}/img/logo/logo.png gambas3.png
		doicon -s 64 -c mimetypes app/mime/*.png main/mime/*.png

		insinto /usr/share/mime/application
		doins app/mime/*.xml main/mime/*.xml
	fi
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
