# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} python3_13t )

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 toolchain-funcs

DESCRIPTION="ESR's utility for making fast comparisons among large source trees"
HOMEPAGE="http://www.catb.org/~esr/comparator/ https://gitlab.com/esr/comparator"
SRC_URI="http://www.catb.org/~esr/comparator/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="=app-text/docbook-xml-dtd-4.1.2*
	app-text/xmlto"

src_prepare() {
	default
	cp -n "${FILESDIR}/setup.cfg" "${FILESDIR}/pyproject.toml" . || die
	sed -e '/python3 setup.py install/d' -i Makefile || die "sed failed"
}

src_test() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" check
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
	emake comparator.html scf-standard.html
	distutils-r1_src_compile
}

src_install() {
	emake ROOT="${D}" install
	distutils-r1_src_install
	docinto html
	dodoc *.html
}
