# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Finds similarities between files"
HOMEPAGE="https://dickgrune.com/Programs/similarity_tester/"
SRC_URI="https://dickgrune.com/Programs/similarity_tester/sim_${PV/./_}.zip"

S="${WORKDIR}"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~x86"
BDEPEND="sys-devel/flex
	app-arch/unzip"

PATCHES=( "${FILESDIR}"/${P}-fix-configuration.patch )

src_compile() {
	emake USER_CC="$(tc-getCC)" USER_CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" binaries
}

src_install() {
	emake DESTDIR="${D}" USER_CC="$(tc-getCC)" USER_CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" install
	dodoc Answers ChangeLog README TechnReport ToDo VERSION sim.pdf
}
