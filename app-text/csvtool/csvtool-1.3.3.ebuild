# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit findlib

DESCRIPTION="a handy command line tool for handling CSV files"
HOMEPAGE="http://forge.ocamlcore.org/projects/csv/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/420/csv-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/ocaml"
RDEPEND="${DEPEND}"

S="${WORKDIR}/csv-${PV}"
#S="${WORKDIR}/csv-1.2.1"

src_compile() {
	default_src_compile
#	emake -C examples
}

src_test() {
	emake test
}

src_install() {
	findlib_src_install
	newbin _build/examples/${PN}.native ${PN}
	dodoc README.txt README.md
}
