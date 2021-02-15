# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Parser for expressions concerning physical values"
HOMEPAGE="https://packages.debian.org/sid/units-filter"
SRC_URI="mirror://debian/pool/main/u/${PN}/${P/r-/r_}.orig.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="app-text/recode
	dev-libs/gmp"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/xz-utils
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}/${PN}"

DOCS=( LISEZMOI README )

src_prepare() {
	sed -i -e 's:grep -q Debian /etc/issue:false:' \
		-e 's@\(install -m 644 units-filter.1\).gz @\1 @' \
		-e '/gzip/d' -e "s@/doc/${PN}/@/doc/${PF}/@" Makefile || die "fixing Makefile failed"
	default
	tc-export CC CXX
}

src_compile() {
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" CC="$(tc-getCC)" CXX="$(tc-getCXX)"
}

src_test() {
	emake test
}

src_install() {
	default DOCDIR="${ED}/usr/share/doc/${PF}"
}
