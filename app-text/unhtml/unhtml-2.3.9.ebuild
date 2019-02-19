# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Remove the markup tags from an HTML file"
HOMEPAGE="https://packages.debian.org/unhtml"
SRC_URI="mirror://debian/pool/main/u/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc Readme.html Readme.txt debian/changelog debian/README.debian \
		debian/copyright
}
