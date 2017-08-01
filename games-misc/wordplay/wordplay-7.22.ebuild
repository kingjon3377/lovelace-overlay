# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit games toolchain-funcs

DESCRIPTION="anagram generator"
HOMEPAGE="http://packages.debian.org/wordplay"
SRC_URI="mirror://debian/pool/main/w/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="wordplay"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	default_src_unpack
	cd "${WORKDIR}" && mv -i ${P}.orig ${P} || die "renaming directory failed"
}

src_prepare() {
	cd "${S}/.." && epatch "${FILESDIR}/wordplay_7.22-17.diff"
	cd "${S}"
	sed -i -e 's:-O:$(CFLAGS):' makefile || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS} ${LDFLAGS}"
}

src_install() {
	dogamesbin wordplay
	newman wordplay.1 ${PN}.6
	dodir "${GAMES_DATADIR}/wordplay"
	insinto "${GAMES_DATADIR}/wordplay"
	doins words721.txt
}
