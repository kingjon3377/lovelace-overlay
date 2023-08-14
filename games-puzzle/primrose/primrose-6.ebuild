# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

DESCRIPTION="compelling tile-placement puzzle game"
HOMEPAGE="https://primrose.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN/p/P}_v${PV}_UnixSource.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="media-libs/libsdl
	virtual/opengl"
DEPEND="${RDEPEND}"
BDEPEND="media-gfx/imagemagick"

S="${WORKDIR}/${PN/p/P}_v${PV}_UnixSource"

PATCHES=( "${FILESDIR}/paths.patch" )

src_prepare() {
	rm tilePlacementGames/game1/build/win32/*.dll || \
		die "removing unused Windows binaries failed"
	rm -r minorGems/util/development/fortify && \
		rm minorGems/graphics/openGL/tga.* minorGems/graphics/openGL/texture.* \
			|| die "Removing unused non-free graphics etc. failed"
	mkdir -p 256x256 128x128 64x64 32x32 || die "creating temporary dirs failed"
	default
}

src_configure() {
	cd "${S}/tilePlacementGames/game1"
	chmod +x ./configure
	platformSelection=1 econf
}

src_compile() {
	mkdir -p 256x256 128x128 64x64 32x32
	convert -scale 256x256 tilePlacementGames/game1/gameSource/iPhone/largeIcon2.png 256x256/primrose.png
	cp -f tilePlacementGames/game1/build/macOSX/iconColor.png 128x128/primrose.png
	convert -background None -gravity center -extent 64x64 \
		tilePlacementGames/game1/gameSource/iPhone/icon.png 64x64/primrose.png
	cp -f tilePlacementGames/game1/build/win32/icon.png 32x32/primrose.png
	convert 32x32/primrose.png 32x32/primrose.xpm
	emake -C "${S}/tilePlacementGames/game1/gameSource" \
		PLATFORM_LINK_FLAGS="-lGL -lSDL -lpthread ${LDFLAGS}" \
		PLATFORM_COMPILE_FLAGS="${CFLAGS} -DETCDIR=\\\"${EPREFIX}/etc/primrose\\\" -DDATADIR=\\\"${EPREFIX}/usr/share/primrose/\\\""
}

src_install() {
	newbin tilePlacementGames/game1/gameSource/Primrose ${PN}
	insinto /usr/share/${PN}
	doins -r tilePlacementGames/game1/gameSource/graphics
	domenu "${FILESDIR}/${PN}.desktop"
	doman "${FILESDIR}/${PN}.6"
	doicon -s 256 256x256/*.png
	doicon -s 128 128x128/*.png
	doicon -s 64 64x64/*.png
	doicon -s 32 32x32/*.png
	doicon 32x32/*.xpm
}
