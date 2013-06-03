# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games eutils

DESCRIPTION="Warcraft 2-like multi-player real-time strategy game"
HOMEPAGE="http://ftp.knoppix.nl/sunsite/games/strategy/"
SRC_URI="http://ftp.knoppix.nl/sunsite/games/strategy/craftcc35.tar.Z
		doc? ( http://ftp.knoppix.nl/sunsite/games/strategy/craftdoc.tar.Z )"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack craftcc35.tar.Z
	use doc && {
		mkdir doc
		cd doc
		unpack craftdoc.tar.Z
	}
}
src_prepare() {
	epatch "${FILESDIR}"/craft-install.patch "${FILESDIR}"/fscanf-void.patch
	for a in field.hc cmap_edit.hc; do
		echo >> "${WORKDIR}/${a}"
	done
}

src_compile() {
	cd "${WORKDIR}"
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" ./install || die "compilation failed"
}

src_install() {
	cd "${WORKDIR}"
	dobin craft
	use doc && {
		dohtml doc/*html
		docinto pic
		dodoc doc/pic/*
	}
}
