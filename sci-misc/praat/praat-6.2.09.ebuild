# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs virtualx desktop

DESCRIPTION="Speech analysis and synthesis"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	mirror://debian/pool/main/p/${PN}/${P/-/_}-1.debian.tar.xz"
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
BDEPEND="app-text/pandoc"

PATCHES=(
	"${WORKDIR}/debian/patches/use-ldflags.patch"
	"${WORKDIR}/debian/patches/cross-build.patch"
	"${WORKDIR}/debian/patches/dwtest-random-seed.patch"
)

src_prepare() {
	default
	# TODO: following line should be updated for non-linux etc. builds
	# (Flammie does not have testing equipment)
	cp "${S}/makefiles/makefile.defs.linux.alsa" "${S}/makefile.defs"
	sed -i -e 's:^CC = gcc:CC = $(USER_CC):' \
		-e 's:^CXX = g++:CXX = $(USER_CXX):' \
		-e 's:^AR = ar:AR = $(USER_AR):' \
		-e 's:^LINK = g++:LINK = $(USER_LINK):' \
		-e '/^CFLAGS/s/ -O[0-9] / /' \
		-e '/^CFLAGS/s/ -g\([0-9]\|\) / /' \
		"${S}/makefile.defs" || die
	sed -i -e 's@xvfb-run -a @@' -e 's@xvfb-run @@' "${WORKDIR}/debian/tests/run-tests" || die
}

src_compile() {
	emake USER_CC="$(tc-getCC) ${CFLAGS}" USER_CXX="$(tc-getCXX) ${CXXFLAGS}" \
		"USER_AR=$(tc-getAR)" "USER_LINK=$(tc-getCXX) ${LDFLAGS} -Wl,--as-needed"
	$(tc-getCC) ${CPPFLAGS} ${CFLAGS} ${LDFLAGS} -Wl,--as-needed -DSTAND_ALONE -DUNIX \
		-o send${PN} sys/send${PN}.c $(pkg-config --cflags --libs gtk+-2.0) -lX11 || die
	for file in ${PN} send${PN} ${PN}-open-files;do
		pandoc --standalone --to man "${WORKDIR}/debian/${file}.md" -o "${file}.1" || die
	done
}

src_test() {
	PRAAT="${S}/${PN}" virtx "${WORKDIR}/debian/tests/run-tests" || die
}

src_install() {
	dobin ${PN} send${PN} ../debian/${PN}-open-files
	doicon ../debian/${PN}.xpm
	insinto /usr/share/icons/hicolor/scalable/apps
	doins main/${PN}.svg
	domenu main/${PN}.desktop
	doman ${PN}.1 send${PN}.1 ${PN}-open-files.1
	newdoc ../debian/What_s_new_.html ChangeLog.html
}
