# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
WX_GTK_VER="2.8"
inherit cmake-utils flag-o-matic wxwidgets

EHG_REVISION="36533b0843bd"

DESCRIPTION="A GPL unbiased renderer"
HOMEPAGE="http://www.luxrender.net"
SRC_URI="http://www.luxrender.net/lux/archive/${EHG_REVISION}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="sse2 doc debug blender"

RDEPEND=">=dev-libs/boost-1.37
	media-libs/openexr
	media-libs/tiff
	media-libs/libpng
	virtual/jpeg
	media-libs/ilmbase
	virtual/opengl
	x11-libs/wxGTK:2.8[X,opengl,sdl]"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	sys-apps/sed
	doc? ( >=app-doc/doxygen-1.5.7[-nodot] )"
PDEPEND="blender? ( =media-gfx/luxblend-${PV} )"

S="${WORKDIR}/lux-${EHG_REVISION}"

src_prepare() {
	sed -i \
		-e "s:^ADD_DEFINITIONS(-O3 -msse2 -mfpmath=sse :ADD_DEFINITIONS(:" \
		CMakeLists.txt || die "Removing CFLAGS failed"
}

src_configure() {
	use sse2 && append-flags "-msse -msse2 -DLUX_USE_SSE"
	use debug && append-flags -ggdb

	need-wxwidgets unicode
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS.txt

	# installing API(s) docs
	if use doc; then
		pushd "${S}"/doxygen > /dev/null
		doxygen doxygen.conf
		dohtml html/*
		popd > /dev/null
	fi

	make_desktop_entry "${PN}" "Lux Render" "/usr/share/pixmaps/luxrender.svg" "Graphics;3DGraphics;"
}
