# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit games eutils

MY_PN=opencity
MY_P=${MY_PN}-${PV}stable

DESCRIPTION="Another city simulator written with OpenGL & SDL"
HOMEPAGE="http://opencity.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

DEPEND="virtual/opengl
		media-libs/libsdl
		media-libs/sdl-mixer
		media-libs/sdl-ttf
		media-libs/sdl-image"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

#src_prepare() {
	#epatch ${FILESDIR}/${P}-gcc34.patch ${FILESDIR}/${P}-includes.patch
#}

src_configure() {
	econf
	# FIXME: We should be patching Makefile.in if there is one, or otherwise
	# moving this to src_prepare().
	epatch "${FILESDIR}"/libs.patch
}

src_compile() {
	emake
}

#src_install() {
#	dodoc docs/FAQ README ChangeLog TODO

#	dodir "${GAMES_DATADIR}/${PN}"
#	cp -r font gui model sound texture "${D}/${GAMES_DATADIR}/${PN}" || die "cp failed"
#	insinto "${GAMES_DATADIR}/${PN}/bin"
#	doins src/${PN} || die "doins failed"
#	echo "#!/bin/sh
#	cd ${GAMES_DATADIR}/${PN}/bin
#	./${PN}" > ${PN}
#	dogamesbin ${PN}
#	prepgamesdirs
#}
