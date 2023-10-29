# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Unpacks .ARC and .ARK MS-DOS archives"
HOMEPAGE="https://packages.debian.org/sid/nomarch"
SRC_URI="mirror://debian/pool/main/n/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="${DEPEND}"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc ChangeLog NEWS README TODO
}
