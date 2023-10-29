# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs edos2unix

DESCRIPTION="Bywater BASIC Interpreter"
HOMEPAGE="https://sourceforge.net/projects/bwbasic/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/version%20${PV}/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

S="${WORKDIR}"

PATCHES=(
	"${FILESDIR}/bwbasic_2.20pl2-9.diff"
	"${FILESDIR}/renum.patch"
	"${FILESDIR}/redefines.patch"
	"${FILESDIR}/${P}-manpage.patch"
)

src_prepare() {
	edos2unix $(find . -type f)
	cp "${PN}.doc" "${PN}.1" || die
	default
	chmod +x configure
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dobin ${PN} renum
	doman ${PN}.1 renum.1
	dodoc README ${PN}.doc
	docinto examples
	dodoc bwbtest/*
}
