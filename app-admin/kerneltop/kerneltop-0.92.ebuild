# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="shows linux kernel function usage in a style like top"
HOMEPAGE="https://www.infradead.org/~rdunlap/src"
SRC_URI="https://www.infradead.org/~rdunlap/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake CC=$(tc-getCC) "CCFLAGS=${CFLAGS} ${CPPFLAGS} ${LDFLAGS}" DEBUG=y all
}

src_install() {
	dobin ${PN}
	newman "${FILESDIR}/${PN}-0.8.1" "${PN}.1"
	dodoc "${FILESDIR}/README.Debian"
}
