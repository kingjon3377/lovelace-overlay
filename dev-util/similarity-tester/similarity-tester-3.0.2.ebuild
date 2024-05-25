# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Finds similarities between files"
HOMEPAGE="https://dickgrune.com/Programs/similarity_tester/"
SRC_URI="https://dickgrune.com/Programs/similarity_tester/sim_$(ver_rs 1- _).zip"

S="${WORKDIR}"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~x86"
BDEPEND="sys-devel/flex
	app-arch/unzip"

PATCHES=(
	"${FILESDIR}/${P}-fix-configuration.patch"
)

DOCS=( ChangeLog README Similarity_Percentage_Computation.tex sim.pdf TechnReport ToDo )

src_prepare() {
	default
	sed -i -e 's@^$(MAN1D)@$(MAN1DIR)@' Makefile || die
}

src_compile() {
	emake -j1 USER_CC="$(tc-getCC)" USER_CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" binaries
}
