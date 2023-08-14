# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Library providing hexadecimal converters"
HOMEPAGE="https://github.com/mirage/ocaml-hex"
SRC_URI="https://github.com/mirage/ocaml-${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

S="${WORKDIR}/ocaml-${P}"

RDEPEND="dev-ml/cstruct:="
DEPEND="${RDEPEND}"
BDEPEND=""
