# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg-utils multilib libtool desktop

DESCRIPTION="A free IDE based on a Basic interpreter with object extensions"
HOMEPAGE="https://gambas.sourceforge.net/"

MY_PN="${PN}${SLOT}"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://gitlab.com/${PN}/${PN}/-/archive/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="3"

KEYWORDS="~amd64"
DEF_ON_FLAGS=( bzip2 cairo curl desktop gtk3 htmlview imageio media mime ncurses net
				opengl pcre pdf qt5 sdl sdlsound sdl2 sqlite svg v4l xml zlib )
DEF_OFF_FLAGS=( crypt dbus examples gmp gsl gtk httpd imageimlib mysql
				postgres odbc openssl openal smtp )
for flag in "${DEF_ON_FLAGS[@]}";do
	IUSE+=" +${flag}"
done
for flag in "${DEF_OFF_FLAGS[@]}";do
	IUSE+=" ${flag}"
done

REQUIRED_USE="gtk3? ( cairo ) gtk? ( cairo ) media? ( v4l ) mysql? ( zlib ) net? ( curl ) sdl? ( opengl ) xml? ( net ) net? ( mime )"

# libcrypt.so is part of glibc
# gtk? ( x11-libs/gtk+:2[cups] )
# TODO: check gtk3, htmlview, other, deps
# TODO: What does sdl2 need beyond libsdl2? (And what USE flags on that package?)
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
		x11-libs/cairo
		svg? ( gnome-base/librsvg:2 )
		x11-libs/gtkglext
	)
	gtk3? (
		x11-libs/gtk+:3
		x11-libs/cairo
	)
	imageio? ( x11-libs/gdk-pixbuf:2 )
	imageimlib?	( media-libs/imlib2 )
	media?	(
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
	)
	mysql?	( >=virtual/mysql-5.0 )
	mime? ( || (
		dev-libs/gmime:3.0
		dev-libs/gmime:2.6
	) )
	ncurses? ( sys-libs/ncurses:0 )
	net? ( >=net-misc/curl-7.13 )
	odbc?	( dev-db/unixODBC )
	openal? ( media-libs/alure )
	opengl?	(
		media-libs/mesa
		|| ( x11-libs/libGLw x11-drivers/nvidia-drivers )
		media-libs/glew:0=
		virtual/glu
	)
	openssl?	( dev-libs/openssl:0 )
	pcre?	( dev-libs/libpcre:3 )
	pdf?	( app-text/poppler:= )
	postgres?	( dev-db/postgresql:= )
	qt5? (
		dev-qt/qtgui:5
		dev-qt/qtwebengine:5
		dev-qt/qtcore:5
		dev-qt/qtopengl:5
	)
	sdl?	(
		>=media-libs/sdl-image-1.2.6-r1
		>=media-libs/sdl-mixer-1.2.7
		media-libs/sdl-ttf
	)
	sdlsound?	( media-libs/sdl-sound )
	sdl2? ( media-libs/libsdl2 )
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
	dev-libs/libffi
	virtual/libcrypt
"

DEPEND="${COMMON_DEPEND}"
BDEPEND="virtual/pkgconfig"

RDEPEND="${COMMON_DEPEND}"

src_prepare() {
	default
	eautoreconf
	while IFS= read -r -d $'\0' subdir;do
		case "${subdir}" in
		*TEMPLATE*) continue ;;
		esac
		test -f "${subdir}/configure" && continue
		pushd "${subdir}" > /dev/null || die "Failed to cd to ${subdir}"
		eautoreconf
		popd > /dev/null || die "Failed to cd back from ${subdir}"
	done < <(find . -name configure.ac -exec dirname {} -z \; | sort -u -z)
}

src_configure() {
	# TODO: What about 'pdf' itself, instead of/as well as 'poppler'?
	econf \
		$(use_enable bzip2 bzlib2) \
		$(use_enable zlib) \
		$(use_enable mysql) \
		$(use_enable odbc) \
		$(use_enable postgres postgresql) \
		--disable-sqlite2 \
		$(use_enable sqlite sqlite3) \
		$(use_enable net) \
		$(use_enable curl) \
		$(use_enable smtp) \
		$(use_enable mime) \
		$(use_enable pcre) \
		$(use_enable sdl) \
		$(use_enable sdlsound) \
		$(use_enable sdl2) \
		$(use_enable xml libxml) \
		$(use_enable xml) \
		$(use_enable v4l) \
		$(use_enable crypt) \
		--disable-qt4 \
		$(use_enable qt5) \
		$(use_enable gtk) \
		$(use_enable gtk3) \
		$(use_enable opengl) \
		$(use_enable desktop x11) \
		$(use_enable desktop keyring) \
		$(use_enable pdf poppler) \
		$(use_enable cairo) \
		$(use_enable imageio) \
		$(use_enable imageimlib) \
		$(use_enable dbus) \
		$(use_enable gsl) \
		$(use_enable gmp) \
		$(use_enable ncurses) \
		$(use_enable media) \
		$(use_enable httpd) \
		$(use_enable openssl) \
		$(use_enable openal) \
		$(use_enable htmlview)
}

src_install() {
	DESTDIR="${D}" emake -j1 install XDG_UTILS= # Sometimes fails with "file exists" errors.

	find "${ED}" -type f -name \*.la -delete || die

	dodoc AUTHORS README TODO
	use net && newdoc gb.net/src/doc/README gb.net-README
	use net && newdoc gb.net/src/doc/changes.txt gb.net-ChangeLog
	use pcre && newdoc gb.pcre/src/README gb.pcre-README
	use sqlite && newdoc gb.db.sqlite3/README gb.db.sqlite3-README
	use smtp && newdoc gb.net.smtp/README gb.net.smtp-README

	if { use qt5 || use gtk || use gtk3; } ; then
		domenu app/desktop/gambas3.desktop

		newicon -s 128 app/src/${MY_PN}/img/logo/logo.png gambas3.png
		doicon -s 64 -c mimetypes app/mime/*.png main/mime/*.png

		insinto /usr/share/mime/application
		doins app/mime/*.xml main/mime/*.xml
	fi
}

my_xdg_update() {
	{ use qt5 || use gtk || use gtk3; } && xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postinst() {
	my_xdg_update
}

pkg_postrm() {
	my_xdg_update
}
