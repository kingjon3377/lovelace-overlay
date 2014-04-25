# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# TODO: make sure this is actually working. ISTR it isn't.

EAPI=5

inherit eutils games autotools

ATRIS_SOUNDS_P=atris-sounds-1.0.1
DESCRIPTION="Alizarin Tetris: Tetris-like game with multi-player and extensible color, shape and sound styles"
HOMEPAGE="http://www.cs.virginia.edu/~weimer/atris/"
SRC_URI="http://www.cs.virginia.edu/~weimer/atris/${P}.tar.gz
	http://www.cs.virginia.edu/~weimer/atris/${ATRIS_SOUNDS_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/freetype-2.1.0
	>=media-libs/libsdl-1.2.0
	media-libs/sdl-ttf"
DEPEND="${RDEPEND}
	sys-devel/automake"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.0.7-install-fix.patch" \
		"${FILESDIR}/${PN}-1.0.7-players-fix.patch" \
		"${FILESDIR}/${PN}-1.0.7-scores-fix.patch"
	eaclocal
	eautomake

	# atris-sounds
	cd "${WORKDIR}/${ATRIS_SOUNDS_P}"
	epatch "${FILESDIR}/${ATRIS_SOUNDS_P}-install-fix.patch"
	eautomake
}

src_configure() {
	egamesconf --prefix=/usr

	# atris-sounds
	cd "${WORKDIR}/${ATRIS_SOUNDS_P}"
	egamesconf --prefix=/usr
}

src_compile() {
	emake

	# atris-sounds
	emake -C "${WORKDIR}/${ATRIS_SOUNDS_P}"
}

src_install() {
	# TODO: Why not emake?
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README Docs/atris.html Docs/faq.html
	make_desktop_entry "${PN}" "Alizarin Tetris" atris.xpm "Games;Arcade"
	insinto /usr/share/pixmaps
	newins icon.xpm atris.xpm

	# atris-sounds
	cd "${WORKDIR}/${ATRIS_SOUNDS_P}"
	make DESTDIR="${D}" install || die "make install failed"
	docinto ${ATRIS_SOUNDS_P}
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
	prepgamesdirs
}
