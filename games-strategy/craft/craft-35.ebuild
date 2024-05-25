# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Warcraft 2-like multi-player real-time strategy game"
HOMEPAGE="https://sourceforge.net/projects/craft-vikings/"
#HOMEPAGE="http://ftp.knoppix.nl/sunsite/games/strategy/"
# TODO: Convert to PV=3.5 and use version-separator replacement to remove them for the filenames
SRC_URI="https://downloads.sourceforge.net/${PN}-vikings/${PN}-vikings/${PN}-3.5/${PN}cc${PV}.tar.Z
		doc? ( https://downloads.sourceforge.net/${PN}-vikings/${PN}-vikings/${PN}-3.5/${PN}doc.tar.Z )"
#SRC_URI="http://ftp.knoppix.nl/sunsite/games/strategy/craftcc35.tar.Z
		#doc? ( http://ftp.knoppix.nl/sunsite/games/strategy/craftdoc.tar.Z )"

S="${WORKDIR}"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc"

src_unpack() {
	unpack ${PN}cc${PV}.tar.Z
	if use doc; then
		mkdir doc
		cd doc
		unpack craftdoc.tar.Z
	fi
}

PATCHES=(
	"${FILESDIR}"/craft-install.patch
	"${FILESDIR}"/craft-install-2.patch
	"${FILESDIR}"/fscanf-void.patch
	"${FILESDIR}/object_handler.patch"
	"${FILESDIR}/getline_rename.patch"
)

src_prepare() {
	default
	touch field.hc cmap_edit.hc || die
}

src_compile() {
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" ./install || die "compilation failed"
}

src_install() {
	dobin ${PN}
	if use doc; then
		dodoc doc/*html
		dodoc -r doc/pic
	fi
}
