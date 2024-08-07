# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Find Equal Files: finds duplicate files in a directory and its subdirectories"
HOMEPAGE="https://www.dickgrune.com/Programs/utils/"
SRC_URI="https://www.dickgrune.com/Programs/utils/${PN}_$(ver_rs 0- _).zip"

S="${WORKDIR}"
LICENSE="BSD"
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
	dodoc README
}
