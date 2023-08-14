# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="OCaml types to Yaml types and back again"
HOMEPAGE="https://github.com/patricoferris/ppx_deriving_yaml"
SRC_URI="https://github.com/patricoferris/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc +ocamlopt test"
RESTRICT="!test? ( test )"

# TODO: Some in DEPEND should probably be BDEPEND instead
RDEPEND="dev-ml/ppxlib:=
	dev-ml/ppx_deriving:=
	dev-ml/yaml:="
DEPEND="${RDEPEND}
	test? (
		dev-ml/alcotest
		dev-ml/bos
		dev-ml/mdx
		dev-ml/ezjsonm
	)
	doc? ( dev-ml/odoc )"
BDEPEND=""
