# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils toolchain-funcs

DESCRIPTION="Parser for expressions concerning physical values"
HOMEPAGE="https://packages.debian.org/sid/units-filter"
SRC_URI="mirror://debian/pool/main/u/${PN}/${P/r-/r_}.orig.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="app-text/recode"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/xz-utils
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}/${PN}"

DOCS=( LISEZMOI README )

src_prepare() {
	sed -i -e 's:grep -q Debian /etc/issue:true:' src/Makefile || die "fixing Makefile failed"
	sed -i -e "s@doc/units-filter/@doc/${PF}/@" Makefile || die
	default
	tc-export CC CXX
}

src_compile() {
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"
}

src_test() {
	emake test
}
