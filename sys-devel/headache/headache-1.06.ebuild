# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Tool to manage license text in source files"
HOMEPAGE="https://www.normalesup.org/~simonet/soft/"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="<dev-ml/camomile-2:="
BDEPEND="dev-lang/ocaml
	dev-libs/libxslt
	dev-libs/libxml2"
RDEPEND="${DEPEND}"

src_install() {
	dodir /usr/bin
	emake INSTALLDIR="${D}/usr/bin" install
	dodoc doc/* README
}
