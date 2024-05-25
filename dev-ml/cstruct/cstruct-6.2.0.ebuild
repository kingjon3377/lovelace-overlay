# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Map OCaml arrays onto C-like structs"
HOMEPAGE="https://github.com/mirage/ocaml-cstruct"
SRC_URI="https://github.com/mirage/ocaml-${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/ocaml-${P}"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

# TODO: Maybe test dependencies should be BDEPEND instead?
RDEPEND="dev-ml/fmt:="
DEPEND="${RDEPEND}
	test? (
		dev-ml/alcotest
		dev-ml/crowbar
	)"
