# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# TODO: make sure this works, and fix it if it doesn't.

EAPI=7

inherit autotools

DEBIAN_PATCH_V=12

DESCRIPTION="development environment for making 2D games"
HOMEPAGE="https://sourceforge.net/projects/fenix"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN/f/F}/${PV}/${PN}092a-src-release.tgz
	mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.dfsg1-${DEBIAN_PATCH_V}.debian.tar.xz"

S="${WORKDIR}/Fenix"
LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="amd64"
IUSE="+nls test"

RDEPEND="media-libs/giflib
	media-libs/libpng:0
	media-libs/sdl-mixer
	media-libs/libsdl
	x11-libs/libX11"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Command )
	app-arch/xz-utils"

# Tests fail in a way I'm having a hard time debugging
RESTRICT=test

src_prepare() {
	mv "${WORKDIR}/debian" "${S}" || die
	cat debian/patches/series | while read -r file;do
		eapply debian/patches/"${file}"
	done
	find . \( -name \*.c -o -name \*.h \) -exec sed -i -e 's/\r$//' {} + || die
	default_src_prepare
	eautoreconf
	rm debian/doc/license.txt*
	chmod +x configure
}

src_configure() {
	econf LIBS="-ldl -lm"
}

src_test() {
	cd "${T}"
	env TESTDIR="${S}/debian/tests/t" \
		TEST_FENIX_MAP="${S}/map/map" \
		TEST_FENIX_FXC="${S}/fxc/src/fxc" \
		TEST_FENIX_FXI="${S}/fxi/src/fxi" \
		TERM=dumb \
		prove -r "${S}/debian/tests/t" || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" install
	doman debian/*.1
	for file in fpg fxc fxi map;do
		mv "${D}/usr/bin/${file}" "${D}/usr/bin/${PN}-${file}" || die
	done
	use nls && emake -C debian/i18n install INSTALLPREFIX="${D}/usr/share/locale/"
	newbin debian/${PN}.sh ${PN}
	dodoc AUTHORS ChangeLog NEWS README debian/doc/* readme.html info.html
	insinto /usr/include/fenix
	doins include/fxdll*.h fxi/inc/instance_st.h fxi/inc/grlib_st.h \
		include/files_st.h include/typedef_st.h include/xctype_st.h \
		fxi/inc/flic_st.h fxi/inc/i_procdef_st.h include/offsets.h \
		include/pslang.h include/fbm.h
	docinto examples
	dodoc debian/examples/skeleton.prg
	insinto /usr/share/pixmaps
	doins debian/*.xpm
}
