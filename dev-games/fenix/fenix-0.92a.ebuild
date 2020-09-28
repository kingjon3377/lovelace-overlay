# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# TODO: make sure this works, and fix it if it doesn't.

EAPI=7

DESCRIPTION="development environment for making 2D games"
HOMEPAGE="https://sourceforge.net/projects/fenix"
SRC_URI="mirror://sourceforge/${PN}/Fenix/${PV}/${PN}092a-src-release.tgz"
#SRC_URI="mirror://debian/pool/main/f/fenix/fenix_0.92a.dfsg1.orig.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="amd64"
IUSE="+nls"

DEPEND="media-libs/giflib
	media-libs/libpng:0
	media-libs/sdl-mixer
	media-libs/libsdl
	x11-libs/libX11"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Fenix"

PATCHES=(
	"${FILESDIR}/configure.patch"
	"${FILESDIR}/i18n_fxc.patch"
	"${FILESDIR}/i18n_fxi_0.patch"
	"${FILESDIR}/i18n_fxi_1.patch"
	"${FILESDIR}/i18n_fxi_2.patch"
	"${FILESDIR}/i18n_fxi_3.patch"
	"${FILESDIR}/i18n_fxi.patch"
	"${FILESDIR}/i18n_fpg.patch"
	"${FILESDIR}/i18n_map.patch"
	"${FILESDIR}/fxi_binname.patch"
	"${FILESDIR}/fxc_nosdlinit.patch"
	"${FILESDIR}/common_stdfiles.patch"
	"${FILESDIR}/fxc_output.patch"
	"${FILESDIR}/fxi_input.patch"
	"${FILESDIR}/fxc_return_values.patch"
	"${FILESDIR}/fxi_return_values.patch"
	"${FILESDIR}/plugins_dir.patch"
	"${FILESDIR}/fxdll_version.patch"
	"${FILESDIR}/fxi_apptitle.patch"
	"${FILESDIR}/puts_gets.patch"
	"${FILESDIR}/version-bump.patch"
	"${FILESDIR}/fxc_misc.patch"
	"${FILESDIR}/fxi_misc_0.patch"
	"${FILESDIR}/fxi_misc_1.patch"
	"${FILESDIR}/fxi_misc_2.patch"
	"${FILESDIR}/fxi_misc_3.patch"
	"${FILESDIR}/0.92a_to_cvs-20070713.1513.patch"
	"${FILESDIR}/endianess.patch"
	"${FILESDIR}/fxi_pal.patch"
	"${FILESDIR}/fxi_sdl_mixer_use_rwops.patch"
	"${FILESDIR}/fxi_pal_get.patch"
	"${FILESDIR}/build_portability.patch"
	"${FILESDIR}/include_fixes.patch"
	"${FILESDIR}/warning_fixes.patch"
	"${FILESDIR}/string_alloc_crash.patch"
)

src_prepare() {
	find . \( -name \*.c -o -name \*.h \) -exec sed -i -e 's/\r$//' {} + || die
	default_src_prepare
	mkdir -p debian/examples debian/doc debian/i18n
	cp "${FILESDIR}/skeleton.prg" debian/examples || die
	cp "${FILESDIR}/fpl.txt" "${FILESDIR}/authors.txt" "${FILESDIR}/fgc.txt" \
		"${FILESDIR}/fpg.txt" "${FILESDIR}/fbm.txt" "${FILESDIR}/fnt.txt" \
		"${FILESDIR}/pal.txt" "${FILESDIR}/map.txt" "${FILESDIR}/formatos.txt" \
		debian/doc || die
	cp "${FILESDIR}/i18n-Makefile" debian/i18n/Makefile || die
	cp "${FILESDIR}/fenix-fxc_es.po" "${FILESDIR}/fenix-fxi_es.po" debian/i18n || die
	sed -i -e 's:ungif:gif:g' configure fpg/Makefile.in map/Makefile.in || die "sed failed"
	chmod +x configure
#	die 'We should probably use the "orig" tarball from Debian, which probably has the ungif fix in it.'
}

src_configure() {
	econf LIBS=-ldl
}

src_install() {
	emake DESTDIR="${D}" install
	doman "${FILESDIR}/"*.1 || die "installing man pages failed"
	pushd "${D}/usr/bin" >/dev/null
	dodir "/usr/games/bin"
	for a in *; do
		mv "${a}" ../games/bin/"${PN}-${a}"
	done
	popd > /dev/null
	use nls && emake -C debian/i18n install INSTALLPREFIX="${D}/usr/share/locale"
	newbin "${FILESDIR}/fenix.sh" ${PN}
	dodoc AUTHORS ChangeLog NEWS README debian/doc/* readme.html info.html
	insinto /usr/include/fenix
	doins include/fxdll*.h fxi/inc/instance_st.h fxi/inc/grlib_st.h \
		include/files_st.h include/typedef_st.h include/xctype_st.h \
		fxi/inc/flic_st.h fxi/inc/i_procdef_st.h include/offsets.h \
		include/pslang.h include/fbm.h
}
