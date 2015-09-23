# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# tosubmit

EAPI=5

inherit games scons-utils toolchain-funcs

DESCRIPTION="a puzzle game inspired by Tetris"
HOMEPAGE="http://blockattack.sf.net"
SRC_URI="mirror://sourceforge/${PN}/binaries+source/Block%20Attack%20${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-games/physfs
	media-libs/sdl-image
	media-libs/sdl-mixer
	net-libs/enet:0"
DEPEND="${RDEPEND}"

src_prepare() {
	cd "${WORKDIR}" && epatch "${FILESDIR}/blockattack_1.3.1-4.diff"
	cd "${S}"
	mv ../${PN}-1.4.1/debian .&&rmdir ../${PN}-1.4.1 || die
	rm debian/patches/desktop_file.diff debian/patches/fix_scons.diff \
		debian/patches/fix_spelling.diff debian/patches/replay_init.diff \
		debian/patches/scons_args.diff
	edos2unix debian/patches/gcc44.diff
	epatch debian/patches/*diff
	cp "${FILESDIR}/${PN}.6" man
	cp "${FILESDIR}/${PN}.desktop" .
	sed -i -e 's:res/testPuzzles:puzzles/testPuzzles:' \
		-e 's:res/puzzle.levels:puzzles/puzzle.levels:' Game/SConscript \
		|| die "sed failed"
	sed -i -e 's:blockattack.6.gz:blockattack.6:' man/SConscript || die "sed failed"
}

src_configure() {
	myesconsargs=(
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		prefix=/usr
		sharedir=${GAMES_DATADIR}/${PN}
		bindir=${GAMES_BINDIR}
		mandir=/usr/share/man
		destdir="${D}"
	)
}

src_compile() {
	escons
}

src_install() {
	find Game -type f -exec chmod 644 \{\} + || die "fixing permissions failed"
	escons install
	rm "${D}/usr/share/games/${PN}/gfx/Thumbs.db"
	dodoc changelog* README AUTHORS block_attack_manual.pdf
}
