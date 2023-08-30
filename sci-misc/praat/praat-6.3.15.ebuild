# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs virtualx desktop

DEBIAN_PATCH_REV=1

DESCRIPTION="Speech analysis and synthesis"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	mirror://debian/pool/main/p/${PN}/${P/-/_}-${DEBIAN_PATCH_REV}.debian.tar.xz"
HOMEPAGE="http://www.fon.hum.uva.nl/praat/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# TODO: README lists a lot more dependencies
RDEPEND="x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libX11
	x11-libs/libICE
	x11-libs/libXext
	x11-libs/libSM
	x11-libs/gtk+:2
	x11-libs/motif:0
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	app-text/xmlto"
BDEPEND="virtual/pandoc"

PATCHES=(
	"${WORKDIR}/debian/patches/use-ldflags.patch"
	"${WORKDIR}/debian/patches/cross-build.patch"
	"${WORKDIR}/debian/patches/dwtest-random-seed.patch"
	"${WORKDIR}/debian/patches/ftbfs-on-i386-with-g++13.patch"
	"${WORKDIR}/debian/patches/return-getphonemesfromtext.patch"
)

src_prepare() {
	default
	# TODO: following line should be updated for non-linux etc. builds
	# (Flammie does not have testing equipment)
	cp "${S}/makefiles/makefile.defs.linux.alsa" "${S}/makefile.defs"
	sed -i \
		-e 's:^AR = ar:AR = $(USER_AR):' \
		-e '/^CFLAGS/s/ -O[0-9] / /' \
		-e '/^CFLAGS/s/ -g\([0-9]\|\) / /' \
		"${S}/makefile.defs" || die
	sed -i -e 's@xvfb-run -a @@' -e 's@xvfb-run @@' "${WORKDIR}/debian/tests/run-tests" || die
}

src_compile() {
	emake CC="$(tc-getCC) ${CFLAGS}" CXX="$(tc-getCXX) ${CXXFLAGS}" \
		"USER_AR=$(tc-getAR)" "LINK=$(tc-getCXX) ${LDFLAGS} -Wl,--as-needed"
	for file in ${PN} ${PN}-open-files;do
		pandoc --standalone --to man "${WORKDIR}/debian/${file}.md" -o "${file}.1" || die
	done
}

src_test() {
	PRAAT="${S}/${PN}" virtx "${WORKDIR}/debian/tests/run-tests" || die
}

src_install() {
	dobin ${PN} ../debian/${PN}-open-files
	doicon ../debian/${PN}.xpm
	insinto /usr/share/icons/hicolor/scalable/apps
	all_svgs=( main/${PN}-*.svg )
	doins main/${PN}-*.svg ../debian/${PN}-file.svg
	case "${#all_svgs[@]}" in
		0) ewarn "main SVG icon missing" ;;
		1) dosym "${#all_svgs[@]}" /usr/share/icons/hicolor/scalable/apps/${PN}.svg ;;
		*) ewarn "Too many SVG icons" ;;
	esac
	domenu main/${PN}.desktop ../debian/${PN}-file.desktop
	doman ${PN}.1 ${PN}-open-files.1
	newdoc ../debian/What_s_new_.html ChangeLog.html
}
