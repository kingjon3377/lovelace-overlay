# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="shows linux kernel function usage in a style like top"
HOMEPAGE="https://www.infradead.org/~rdunlap/src"
SRC_URI="https://www.infradead.org/~rdunlap/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	eapply "${FILESDIR}"/*.patch
	gunzip ${PN}.1.gz
	default
}

src_compile() {
	emake CC=$(tc-getCC) "CCFLAGS=${CFLAGS}" DEBUG=y all
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc "${FILESDIR}/README.Debian"
}
