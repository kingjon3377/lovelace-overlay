# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="WordPerfect 5.x documents to whatever converter"
HOMEPAGE="ftp://ftp.penguin.cz/pub/users/mhi/wp2x"
SRC_URI="ftp://ftp.penguin.cz/pub/users/mhi/wp2x/${P}-mhi.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
# Tests fail for some reason
RESTRICT="test"

S="${WORKDIR}/${P}-mhi"

src_prepare() {
	cd "${WORKDIR}" && epatch "${FILESDIR}/wp2x_2.5-mhi-9.diff"
	cd "${S}" && epatch debian/patches/*patch
}

src_compile() {
	emake CC="$(tc-getCC) ${CFLAGS}"
}

src_test() {
	emake CC="$(tc-getCC) ${CFLAGS}" test
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog README TODO
}
