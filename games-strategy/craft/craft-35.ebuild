# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Warcraft 2-like multi-player real-time strategy game"
HOMEPAGE="https://sourceforge.net/projects/craft-vikings/"
#HOMEPAGE="http://ftp.knoppix.nl/sunsite/games/strategy/"
SRC_URI="mirror://sourceforge/${PN}-vikings/${PN}-vikings/${PN}-3.5/${PN}cc${PV}.tar.Z
		doc? ( mirror://sourceforge/${PN}-vikings/${PN}-vikings/${PN}-3.5/${PN}doc.tar.Z )"
#SRC_URI="http://ftp.knoppix.nl/sunsite/games/strategy/craftcc35.tar.Z
		#doc? ( http://ftp.knoppix.nl/sunsite/games/strategy/craftdoc.tar.Z )"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc"

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

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
	"${FILESDIR}"/fscanf-void.patch
	"${FILESDIR}/object_handler.patch"
	"${FILESDIR}/getline_rename.patch"
)

src_prepare() {
	default
	for a in field.hc cmap_edit.hc; do
		echo >> "${WORKDIR}/${a}"
	done
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
