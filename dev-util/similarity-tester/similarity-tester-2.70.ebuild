# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Finds similarities between files"
HOMEPAGE="http://dickgrune.com/Programs/similarity_tester/"
SRC_URI="http://dickgrune.com/Programs/similarity_tester/sim_${PV/./_}.zip"

LICENSE="BSD"
SLOT="0"

KEYWORDS="x86 amd64"
IUSE=""
DEPEND="sys-devel/flex"
RDEPEND=""

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-configuration.patch
}

src_compile() {
	emake DESTDIR="${D}" USER_CC="$(tc-getCC)" USER_CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" binaries
}

src_install() {
	emake DESTDIR="${D}" USER_CC="$(tc-getCC)" USER_CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" install
	dodoc Answers ChangeLog README TechnReport ToDo VERSION sim.pdf
}
