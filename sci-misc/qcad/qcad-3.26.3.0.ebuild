# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LANGS="cs da de el en es et fr hu it nl no pa pl ru sk tr"
inherit wrapper desktop qmake-utils

manual_cs="2.0.4.0-1"
manual_de="2.1.0.0-1"
manual_en="2.1.0.0-1"
manual_hu="2.0.4.0-1"

LANGS_M="cs de en hu"

DESCRIPTION="A 2D CAD package based upon Qt."
# ugly hack, don't make en L10N-controlled as we may need it as default
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tgz"
HOMEPAGE="https://www.ribbonsoft.com/en/qcad-downloads-trial https://github.com/qcad/qcad"

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
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/designer:5
	dev-qt/qtsql:5
	dev-qt/qthelp:5
	dev-qt/qtscript:5[scripttools]
	"
DEPEND="${RDEPEND}"
BDEPEND=">=sys-devel/gcc-4"

src_prepare() {
	local qt_version=$(best_version dev-qt/qtscript:5 | sed 's@dev-qt/qtscript-@@')
	if ! test -d src/3rdparty/qt-labs-qtscriptgenerator-${qt_version}; then
		local fname=qt-labs-qtscriptgenerator
		same_slot_version=$(ls -d src/3rdparty/${fname}-$(ver_cut 1-2 ${qt_version})* | \
							tail -n 1 | sed "s@src/3rdparty/${fname}-@@")
		test -n "${same_slot_version}" || die "No QtScript bindings in the same SLOT as ${qt_version}"
		mkdir -p src/3rdparty/${fname}-${qt_version} || die
		cp "src/3rdparty/${fname}-${same_slot_version}/${fname}-${same_slot_version}.pro" \
			"src/3rdparty/${fname}-${qt_version}/${fname}-${qt_version}.pro" || die
	fi
	sed -i -e "s@'\\\$\$ORIGIN'@'\\\$ORIGIN'@" shared.pri || die
	default
}

src_configure() {
	eqmake5 LIBDIR="/usr/$(get_libdir)" PREFIX="/usr" LDFLAGS="${LDFLAGS} -Wl,-rpath=/usr/$(get_libdir)/${PN}"
}

src_install() {
	dodir /usr/share/pixmaps /usr/share/applications
	insinto "/usr/$(get_libdir)/${PN}"
	doins -r examples fonts libraries linetypes patterns platforminputcontexts platforms plugins \
		scripts themes ts xcbglintegrations
	doins release/*.so release/${PN}-bin
	doman ${PN}.1
	dodoc readme.txt

	doicon scripts/qcad_icon.png
	make_desktop_entry /usr/bin/${PN} "QCad" ${PN}_icon 'Application;Development;Electronics;Engineering;'
	make_wrapper ${PN} "/usr/$(get_libdir)/${PN}/${PN}-bin" "" "/usr/$(get_libdir)/${PN}"
	fperms +x "/usr/$(get_libdir)/${PN}/${PN}-bin"

	# FIXME:  Unresolved soname dependencies:
	# /usr/lib64/qcad/libqcadecmaapi.so: libqcadcore.so libqcadentity.so libqcadgui.so libqcadoperations.so
	# /usr/lib64/qcad/libqcadentity.so: libqcadcore.so
	# /usr/lib64/qcad/libqcadgrid.so: libqcadcore.so
	# /usr/lib64/qcad/libqcadgui.so: libqcadcore.so libqcadentity.so
	# /usr/lib64/qcad/libqcadoperations.so: libqcadcore.so libqcadentity.so
	# /usr/lib64/qcad/libqcadsnap.so: libqcadcore.so libqcadentity.so
	# /usr/lib64/qcad/libqcadspatialindex.so: libqcadcore.so
	# /usr/lib64/qcad/plugins/designer/libqcadcustomwidgets.so: libqcadgui.so
	# /usr/lib64/qcad/plugins/libqcaddxf.so: libqcadcore.so libqcadentity.so libqcadoperations.so
	# /usr/lib64/qcad/plugins/libqcadscripts.so: libqcadcore.so
	# /usr/lib64/qcad/qcad-bin: libqcadcore.so libqcadentity.so

	# FIXME: Pre-strips files
}
