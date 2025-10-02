# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs virtualx desktop

DEBIAN_EXTRA_REV=+dfsg
DEBIAN_PATCH_REV=1

DESCRIPTION="Speech analysis and synthesis"
HOMEPAGE="http://www.fon.hum.uva.nl/praat/"
P_FOR_DEB=${P/-/_}
P_FOR_DEB=${P_FOR_DEB/4a/4.a}
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	mirror://debian/pool/main/p/${PN}/${P_FOR_DEB}${DEBIAN_EXTRA_REV}-${DEBIAN_PATCH_REV}.debian.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

# TODO: README lists a lot more dependencies
# TODO: Make GUI optional
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
	"${WORKDIR}/debian/patches/honor-cppflags.patch"
	"${WORKDIR}/debian/patches/praat-launch-in-desktop.patch"
	"${WORKDIR}/debian/patches/real-file-icon.patch"
	"${WORKDIR}/debian/patches/avoid-dangling-hyperlinks.patch"
)

S="${WORKDIR}/${PN}.github.io-${PV}"

src_prepare() {
	default
	# TODO: following line should be updated for non-linux etc. builds
	# (Flammie does not have testing equipment)
	cp "${S}/makefiles/makefile.defs.linux.alsa" "${S}/makefile.defs" || die
	sed -i \
		-e 's:^AR = ar:AR = $(USER_AR):' \
		"${S}/makefile.defs" || die
	sed -n '/^R"~~~(/,/^)~~~"/{/^R"~~~(/!{/^)~~~"/!p}}' fon/manual_whatsnew.cpp > ../debian/what-is-new || die
}

src_compile() {
	emake CC="$(tc-getCC) -fexcess-precision=fast ${CFLAGS}" \
		CXX="$(tc-getCXX) -fexcess-precision=fast ${CXXFLAGS}" \
		CPP="$(tc-getCPP) ${CPPFLAGS}" AR="$(tc-getAR)" \
		"USER_AR=$(tc-getAR)" "LINK=$(tc-getCXX) ${LDFLAGS} -Wl,--as-needed"
	for file in ${PN} ${PN}-launch;do
		pandoc --standalone --to man "${WORKDIR}/debian/${file}.md" -o "${file}.1" || die
	done
}

src_test() {
	PRAAT="${S}/${PN}" virtx "${WORKDIR}/debian/tests/run-tests" || die
}

src_install() {
	dobin ${PN} ../debian/${PN}-launch
	doicon ../debian/${PN}.xpm
	doicon -s scalable main/${PN}-480.svg
	domenu main/${PN}.desktop
	doman ${PN}.1 ${PN}-launch.1
	newdoc ../debian/what-is-new ChangeLog
	dodoc ../debian/NEWS
}
