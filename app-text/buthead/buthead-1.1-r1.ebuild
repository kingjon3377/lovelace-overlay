# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="copy all but the first few lines"
HOMEPAGE="https://packages.debian.org/unstable/buthead"
SRC_URI="mirror://debian/pool/main/b/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-harden.patch" )

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	doman ${PN}.1
	emake DESTDIR="${D}" prefix="/usr" install
}
