# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="persistent-mode afl-fuzz for ocaml"
HOMEPAGE="https://github.com/stedolan/ocaml-afl-persistent"
SRC_URI="https://github.com/stedolan/ocaml-${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/ocaml-${P}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="${DEPEND}"
