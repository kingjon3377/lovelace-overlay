# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LANGS="cs da de el en es et fr hu it nl no pa pl ru sk tr"
inherit eutils qmake-utils

manual_cs="2.0.4.0-1"
manual_de="2.1.0.0-1"
manual_en="2.1.0.0-1"
manual_hu="2.0.4.0-1"

LANGS_M="cs de en hu"

DESCRIPTION="A 2D CAD package based upon Qt."
# ugly hack, don't make en L10N-controlled as we may need it as default
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.zip -> ${P}.zip"
HOMEPAGE="http://www.ribbonsoft.com/en/qcad-downloads-trial https://github.com/qcad/qcad"

LICENSE="GPL-3 public-domain CC-BY-3.0 GPL-2+ LGPL-2.1 BSD-2"
SLOT="0"
IUSE="doc"
KEYWORDS="~amd64 ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	media-libs/glu
	media-libs/freetype
	media-libs/fontconfig
	dev-libs/openssl:0
	sys-apps/dbus
	x11-libs/libSM
	media-libs/mesa
	dev-qt/qtopengl:5
	dev-qt/qtwebkit:5
	dev-qt/qtgui:5
	dev-qt/designer:5[webkit]
	dev-qt/qtsql:5
	dev-qt/qthelp:5
	dev-qt/qtscript:5[scripttools]
	"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-4"

src_prepare() {
	# FIXME: Figure out dynamically which Qt 5.x version we're building
	# against, and which 5.x.y is the latest version listed, and set the
	# build up properly, instead of specifying the "current" one at
	# ebuild-revision time.
	if has_version '>=dev-qt/qtscript-5.9.6' && ! test -d src/3rdparty/qt-labs-qtscriptgenerator-5.9.6;then
		local fname=qt-labs-qtscriptgenerator
		mkdir -p src/3rdparty/${fname}-5.9.6 || die
		cp src/3rdparty/${fname}-5.9.5/${fname}-5.9.5.pro \
			src/3rdparty/${fname}-5.9.6/${fname}-5.9.6.pro || die
	fi
}

src_configure() {
	eqmake5 LIBDIR="/usr/$(get_libdir)" PREFIX="/usr"
}

src_install() {
	dodir /usr/share/${PN} /usr/share/pixmaps /usr/share/applications
	# FIXME: Libraries shouldn't go under /usr/share !
	insinto /usr/share/${PN}
	doins -r examples fonts libraries patterns plugins scripts ts
	doins release/*
	dodoc readme.txt
	# following the Arch PKGBUILD; don't know if this is needed ...
	dodir /usr/share/${PN}/plugins/{designer,imageformats,sqldrivers,codecs}
	dodir /usr/share/${PN}/plugins/imageformats
	{
		cd /usr/$(get_libdir)/qt5/plugins/
		ls designer/libqwebview.so imageformats/*.so sqldrivers/*.so codecs/*.so
	} | while read file; do
		dosym ../../../$(get_libdir)/qt5/plugins/${file} /usr/share/${PN}/plugins/${file}
	done

	doicon scripts/qcad_icon.png
	make_desktop_entry /usr/bin/${PN} "QCad" ${PN}_icon.png 'Application;Development;Electronics;Engineering;'
	make_wrapper ${PN} /usr/share/${PN}/${PN}-bin "" /usr/share/${PN}
	fperms +x /usr/share/${PN}/${PN}-bin
}