# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs edos2unix

DESCRIPTION="Bywater BASIC Interpreter"
HOMEPAGE="https://sourceforge.net/projects/bwbasic/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/version%20${PV}/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

PATCHES=(
	"${FILESDIR}/bwbasic_2.20pl2-9.diff"
	"${FILESDIR}/renum.patch"
	"${FILESDIR}/redefines.patch"
)

src_prepare() {
	edos2unix $(find . -type f)
	default
	chmod +x configure
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dobin bwbasic renum
	doman debian/renum.1
	doman "${FILESDIR}/bwbasic.1"
	dodoc README bwbasic.doc
	docinto examples
	dodoc bwbtest/*
}
