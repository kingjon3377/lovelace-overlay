# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LANGS="cs da de el en es et fr hu it nl no pa pl ru sk tr"
inherit wrapper desktop qmake-utils cmake

manual_cs="2.0.4.0-1"
manual_de="2.1.0.0-1"
manual_en="2.1.0.0-1"
manual_hu="2.0.4.0-1"

LANGS_M="cs de en hu"

DESCRIPTION="A 2D CAD package based upon Qt."
HOMEPAGE="https://www.ribbonsoft.com/en/qcad-downloads-trial https://github.com/qcad/qcad"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/${PN}/qtjsapi/archive/v${PV}.tar.gz -> qtjsapi-${PV}.tar.gz
	https://github.com/qcad/qcadjsapi/archive/v${PV}.tar.gz -> ${PN}jsapi-${PV}.tar.gz"

LICENSE="GPL-3 public-domain CC-BY-3.0 GPL-2+ LGPL-2.1 BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RDEPEND="dev-qt/qtsvg:6=
	dev-qt/qttools:6=
	dev-qt/qtshadertools:6=
	dev-qt/qt5compat:6=
	dev-qt/qtdeclarative:6=
	dev-qt/qtbase:6=
	media-libs/libglvnd
	virtual/glu
	dev-util/vulkan-headers
	"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_QT6=ON
		-DCMAKE_INSTALL_RPATH=/usr/$(get_libdir)/${PN}
		-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
		-DCMAKE_BUILD_TYPE=Release
	)
	for dir in "${WORKDIR}/qtjsapi-${PV}" "${S}" "${WORKDIR}/${PN}jsapi-${PV}";do
		cmake_run_in "${dir}" cmake_src_configure
	done
}

src_compile() {
	for dir in "${WORKDIR}/qtjsapi-${PV}" "${S}" "${WORKDIR}/${PN}jsapi-${PV}";do
		cmake_run_in "${dir}" cmake_src_compile
	done
}

src_install() {
	# FIXME: /usr/$(get_libdir)/qcad/plugins/libqcadstemmer.so: unresolved SONAME dependency on libstemmer.so (which is in /usr/$(get_libdir))
	dodir /usr/$(get_libdir)/${PN}
	insinto /usr/$(get_libdir)/${PN}
	doins -r examples fonts libraries linetypes patterns scripts themes ts plugins
	insinto /usr/$(get_libdir)/${PN}/plugins
	doins "${BUILD_DIR}/src/3rdparty/dxflib/libdxflib.so" "${S}/debug/"*.so
	doman "${PN}.1"
	dodoc readme.txt
	newicon scripts/qcad_icon.png org.qcad.QCAD.png
	newicon --size scalable scripts/qcad_icon.svg org.qcad.QCAD.svg
	insinto /usr/share/applications
	newins ${PN}.desktop org.qcad.QCAD.desktop
	dobin "${S}/debug/${PN}-bin"
	make_wrapper ${PN} /usr/$(get_libdir)/${PN}/${PN}-bin
}
