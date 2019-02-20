# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs eutils

DESCRIPTION="BBC BASIC V interpreter"
HOMEPAGE="https://sourceforge.net/projects/brandy"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/libsdl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_/}"

PATCHES=(
	"${FILESDIR}/${PN}_${PV}-2.diff"
)

src_compile() {
	emake CC=$(tc-getCC) LD=$(tc-getCC) CFLAGS="-I/usr/include/SDL ${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin brandy
	doman "${FILESDIR}/brandy.1"
	rm docs/COPYING
	dodoc docs/*
	dodoc -r examples
}
