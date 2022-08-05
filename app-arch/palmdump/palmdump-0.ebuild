# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Dump contents of a Palm PDB/PRC archive"
HOMEPAGE="https://www.fourmilab.ch/palm/palmdump"
SRC_URI="https://www.fourmilab.ch/palm/${PN}/${PN}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

S="${WORKDIR}"

src_prepare() {
	sed -i -e '/^CC/s/^/#/' -e '/^CFLAGS/s/^/#/' Makefile || die
	default
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" "${PN}"
}

src_install() {
	dobin "${PN}"
	dodoc TRADEMARKS ${PN}.html
}
