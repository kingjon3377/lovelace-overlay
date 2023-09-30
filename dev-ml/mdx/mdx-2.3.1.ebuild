# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Execute code blocks inside your documentation"
HOMEPAGE="https://github.com/realworldocaml/mdx"
SRC_URI="https://github.com/realworldocaml/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/fmt:=
	dev-ml/cppo:=
	dev-ml/csexp:=
	dev-ml/astring:=
	dev-ml/cmdliner:=
	dev-ml/re:=
	dev-ml/ocaml-version:=
	!<dev-ml/result-1.5"
DEPEND="${RDEPEND}
	test? (
		dev-ml/lwt
		dev-ml/alcotest
	)"
BDEPEND=""
