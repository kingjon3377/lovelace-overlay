# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs versionator

DESCRIPTION="Finds similarities between files"
HOMEPAGE="https://dickgrune.com/Programs/similarity_tester/"
SRC_URI="https://dickgrune.com/Programs/similarity_tester/sim_$(replace_all_version_separators _).zip"

LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="sys-devel/flex
	app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"

PATCHES=(
	"${FILESDIR}/${P}-fix-configuration.patch"
)

DOCS=( ChangeLog README Similarity_Percentage_Computation.tex sim.pdf TechnReport ToDo )

src_prepare() {
	default
	sed -i -e 's@^$(MAN1D)@$(MAN1DIR)@' Makefile || die
}

src_compile() {
	emake -j1 DESTDIR="${D}" USER_CC="$(tc-getCC)" USER_CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" binaries
}
