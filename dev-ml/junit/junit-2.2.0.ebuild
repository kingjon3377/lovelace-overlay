# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="OCaml package to produce JUnit xml reports"
HOMEPAGE="https://github.com/Khady/ocaml-junit"
SRC_URI="https://github.com/Khady/ocaml-${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/ocaml-${P}"

LICENSE="LGPL-3-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc +ocamlopt test"
RESTRICT="!test? ( test )"

# TODO: doc dep should maybe be BDEPEND?
RDEPEND="dev-ml/ptime:=
	dev-ml/tyxml:=
	dev-ml/alcotest:=
	dev-ml/ounit2:="
DEPEND="${RDEPEND}
	doc? ( dev-ml/odoc )"

src_install() {
	dune-install junit junit_alcotest junit_ounit
}
