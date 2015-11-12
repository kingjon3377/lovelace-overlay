# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Tool to manage license text in source files"
HOMEPAGE="http://cristal.inria.fr/~simonet/soft/"
SRC_URI="http://www.normalesup.org/~simonet/soft/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/ocaml"
RDEPEND="${DEPEND}"

src_install() {
	dodir /usr/bin
	emake INSTALLDIR="${D}/usr/bin" install
	dodoc doc/* README
}
