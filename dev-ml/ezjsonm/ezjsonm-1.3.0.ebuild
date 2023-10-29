# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="An easy interface on top of dev-ml/jsonm"
HOMEPAGE="https://github.com/mirage/ezjsonm"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

# Tests seem to require NPM to be installed?
RESTRICT="test"

# TODO: Some in DEPEND should probably be BDEPEND instead
# test? ( dev-ml/js_of_ocaml-compiler dev-ml/conf-npm )
RDEPEND="dev-ml/jsonm:=
	dev-ml/uutf:=
	dev-ml/sexplib0:=
	dev-ml/hex:="
DEPEND="${RDEPEND}
	test? ( dev-ml/alcotest )
	"
