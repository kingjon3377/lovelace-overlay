# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LANGS="cs da de el en es et fr hu it nl no pa pl ru sk tr"
inherit eutils qmake-utils versionator

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
	local qt_version=$(best_version dev-qt/qtscript:5 | sed 's@dev-qt/qtscript-@@')
	if ! test -d src/3rdparty/qt-labs-qtscriptgenerator-${qt_version}; then
		local fname=qt-labs-qtscriptgenerator
		same_slot_version=$(ls -d src/3rdparty/${fname}-$(get_version_component_range 1-2 ${qt_version})* | \
							tail -n 1 | sed "s@src/3rdparty/${fname}-@@")
		test -n "${same_slot_version}" || die "No QtScript bindings in the same SLOT as ${qt_version}"
		mkdir -p src/3rdparty/${fname}-${qt_version} || die
		cp "src/3rdparty/${fname}-${same_slot_version}/${fname}-${same_slot_version}.pro" \
			"src/3rdparty/${fname}-${qt_version}/${fname}-${qt_version}.pro" || die
	fi
	default
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
