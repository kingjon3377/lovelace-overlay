# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="recover files/disks with damaged sectors"
HOMEPAGE="https://www.vanheusden.com/recoverdm/"
SRC_URI="https://www.vanheusden.com/recoverdm/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's:-O2:$(USER_CFLAGS):' Makefile || die "sed failed"
	default
}

src_compile() {
	emake CC=$(tc-getCC) USER_CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin recoverdm mergebad
	dodoc readme.txt
}
