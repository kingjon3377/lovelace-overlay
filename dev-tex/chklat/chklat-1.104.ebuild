# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="LaTeX static analysis checker"
HOMEPAGE="https://www.dickgrune.com/Programs/LaTeXTools/chklat"
SRC_URI="https://www.dickgrune.com/Programs/LaTeXTools/${PN}/${PN}_$(ver_rs 1 _).zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip
	dev-texlive/texlive-latex"

S="${WORKDIR}"

src_prepare() {
	default
	sed -i -e 's@^ @	@' -e 's@.*C:/@#&@' -e 's@^EXE =[ 	]*\.exe@#&@' Makefile || die
}

src_compile() {
	emake -j1 DIR=/usr BINDIR=/usr/bin MAN1DIR=/usr/share/man/man1 ${PN} CC=$(tc-getCC) \
		CFLAGS="${CFLAGS} -DDEBUG -fPIC"
	emake DIR=/usr BINDIR=/usr/bin MAN1DIR=/usr/share/man/man1 ${PN}.pdf
}

src_test() {
	emake test
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	emake DIR="${ED}/usr" BINDIR="${ED}/usr/bin" MAN1DIR="${ED}/usr/share/man/man1" install
	dodoc ChangeLog README ToDo
}
