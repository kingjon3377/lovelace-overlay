# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="WordPerfect 5.x documents to whatever converter"
HOMEPAGE="ftp://ftp.penguin.cz/pub/users/mhi/wp2x"
SRC_URI="ftp://ftp.penguin.cz/pub/users/mhi/${PN}/${P}-mhi.tar.bz2
	mirror://debian/pool/main/w/${PN}/${PN}_${PV}-mhi-13.debian.tar.xz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="app-arch/xz-utils"

S="${WORKDIR}/${P}-mhi"

src_prepare() {
	for file in $(cat "${WORKDIR}/debian/patches/series");do
		eapply "${WORKDIR}/debian/patches/${file}"
	done
	default
}

src_configure() {
	tc-export CC
}

src_compile() {
	emake CFLAGS="${CFLAGS} ${CPPFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_test() {
	emake CFLAGS="${CFLAGS}" CPPFLAGS="${CPPFLAGS}" LDFLAGS="${LDFLAGS}" test
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog README TODO
}
