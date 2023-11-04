# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Parse and generate YAML 1.1/1.2 files"
HOMEPAGE="https://github.com/avsm/ocaml-yaml"
SRC_URI="https://github.com/avsm/ocaml-${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/ocaml-${P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ocaml-ctypes:=
	dev-ml/bos:="
DEPEND="${DEPEND}
	dev-ml/dune-configurator
	test? (
		dev-ml/fmt
		dev-ml/logs
		dev-ml/mdx
		dev-ml/alcotest
		dev-ml/crowbar
		dev-ml/ezjsonm
		dev-ml/junit
	)"
