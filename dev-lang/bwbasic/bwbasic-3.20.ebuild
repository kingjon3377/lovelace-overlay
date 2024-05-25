# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs edos2unix

DESCRIPTION="Bywater BASIC Interpreter"
HOMEPAGE="https://sourceforge.net/projects/bwbasic/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN}/version%20${PV}/${P}.zip"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

PATCHES=( "${FILESDIR}/${P}-manpage.patch" )

src_prepare() {
	edos2unix $(find . -type f)
	chmod +x configure
	cp "${PN}.doc" "${PN}.1" || die
	echo '.so man1/bwbasic.1' > renum.1
	default
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dobin bwbasic renum
	doman ${PN}.1 renum.1
	dodoc README bwbasic.doc DOCS/* example.bas
}
