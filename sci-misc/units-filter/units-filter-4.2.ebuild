# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit toolchain-funcs python-single-r1

DESCRIPTION="Parser for expressions concerning physical values"
HOMEPAGE="https://packages.debian.org/sid/units-filter"
SRC_URI="mirror://debian/pool/main/u/${PN}/${P/r-/r_}.orig.tar.xz"

LICENSE="GPL-2 LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui"

REQUIRED_USE="gui? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="app-text/recode
	dev-libs/gmp
	gui? (
		gnome-base/librsvg
		${PYTHON_DEPS}
		$(python_gen_cond_dep 'dev-python/PyQt5[${PYTHON_USEDEP}]')
	)"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/xz-utils
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}/${PN}"

DOCS=( LISEZMOI.rst README.rst )

src_prepare() {
	sed -i -e 's:grep -q Debian /etc/issue:false:' \
		-e 's@\(install -m 644 units-filter.1\).gz @\1 @' \
		-e '/gzip/d' -e "s@/doc/${PN}/@/doc/${PF}/@" Makefile || die "fixing Makefile failed"
	sed -i -e 's@rst2html @rst2html.py @' \
		-e 's@\.1\.gz@.1@' gui/Makefile || die "fixing gui/Makefile failed"
	default
	tc-export CC CXX
}

src_compile() {
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" CC="$(tc-getCC)" CXX="$(tc-getCXX)"
	use gui && emake -C gui CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" \
		CC="$(tc-getCC)" CXX="$(tc-getCXX)"
}

src_test() {
	emake test
}

src_install() {
	default DOCDIR="${ED}/usr/share/doc/${PF}"
	use gui && emake -C gui DESTDIR="${D}" install
}
