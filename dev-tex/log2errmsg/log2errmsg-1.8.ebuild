# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Extracts first error message from a LaTeX log"
HOMEPAGE="https://dickgrune.com/Programs/LaTeXTools/log2errmsg/"
SRC_URI="https://dickgrune.com/Programs/LaTeXTools/${PN}/${PN}_$(ver_rs 0- _).zip"

S="${WORKDIR}"
LICENSE="GPL-3" # "GNU License", specified in 2019
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

PATCHES=( "${FILESDIR}/${P}-portability.patch" )

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" ${PN}
}

src_install() {
	emake DIR="${ED}/usr" install
	dodoc ChangeLog README
	doman ${PN}.1
}
