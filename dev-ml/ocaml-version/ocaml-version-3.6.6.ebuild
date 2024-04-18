# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Library to parse and enumerate releases of the OCaml compiler"
HOMEPAGE="https://github.com/ocurrent/ocaml-version"
SRC_URI="https://github.com/ocurrent/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc +ocamlopt test"
RESTRICT="!test? ( test )"

# TODO: Deps in DEPEND should probably be BDEPEND instead?
DEPEND="${RDEPEND}
	test? ( dev-ml/alcotest )
	doc? ( dev-ml/odoc )"
