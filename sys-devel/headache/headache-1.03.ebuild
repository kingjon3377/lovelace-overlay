# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Tool to manage license text in source files"
HOMEPAGE="https://www.normalesup.org/~simonet/soft/"
SRC_URI="http://www.normalesup.org/~simonet/soft/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/ocaml"
BDEPEND="dev-lang/ocaml"
RDEPEND="${DEPEND}"

src_install() {
	dodir /usr/bin
	emake INSTALLDIR="${D}/usr/bin" install
	dodoc doc/* README
}
