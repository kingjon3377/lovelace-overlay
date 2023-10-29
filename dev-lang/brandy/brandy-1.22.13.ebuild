# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="BBC BASIC V interpreter"
HOMEPAGE="http://brandy.matrixnetwork.co.uk/ https://github.com/stardot/MatrixBrandy/"
SRC_URI="https://github.com/stardot/MatrixBrandy/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/libsdl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Matrix${PN/b/B}-${PV}"

# Just rebuilds the main executable with different flags ...
RESTRICT=test

src_compile() {
	emake CC=$(tc-getCC) LD=$(tc-getCC) BRANDY_BUILD_FLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin ${PN}
	doman "${FILESDIR}/brandy.1"
	rm docs/COPYING
	dodoc docs/*
	dodoc -r examples
}
