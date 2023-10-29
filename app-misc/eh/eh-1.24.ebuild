# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="gives a first impression of the contents of its arguments, much like file"
HOMEPAGE="https://www.dickgrune.com/Programs/utils/"
SRC_URI="https://www.dickgrune.com/Programs/utils/${PN}_$(ver_rs 0- _).zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

S="${WORKDIR}"

PATCHES=( "${FILESDIR}/${P}-portability.patch" )

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" VERSION=${PV} ${PN}
}

src_install() {
	emake DIR="${ED}/usr" install
	dodoc README
}
