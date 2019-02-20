# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs eutils

DESCRIPTION="Bywater BASIC Interpreter"
HOMEPAGE="https://sourceforge.net/projects/bwbasic/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/version%20${PV}/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"

src_prepare() {
	edos2unix $(find . -type f)
	chmod +x configure
	echo '.so man1/bwbasic.1' > renum.1
	default
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dobin bwbasic renum
	doman "${FILESDIR}/bwbasic.1" renum.1
	dodoc README bwbasic.doc DOCS/* example.bas
}
