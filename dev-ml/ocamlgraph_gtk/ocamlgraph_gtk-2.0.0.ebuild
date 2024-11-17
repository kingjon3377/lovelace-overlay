# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dune

BASE_PN=ocamlgraph
DESCRIPTION="O'Caml Graph Library (GTK UI portion)"
HOMEPAGE="http://ocamlgraph.lri.fr/index.en.html"
SRC_URI="https://github.com/backtracking/${BASE_PN}/releases/download/${PV}/${BASE_PN}-${PV}.tbz"

S=${WORKDIR}/${BASE_PN}-${PV}
LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

# * ocaml>=4.03.0
# * stdlib-shims
# * lablgtk
# * conf-gnomecanvas
# * ocamlgraph>=2.0.0
# * dune>=2.0 & !with-test | >=2.8
# * graphicswith-test

# As of 2.0.0, ocamlgraph ebuild still includes most(?) necessary deps
RDEPEND=">=dev-ml/ocamlgraph-${PV}:=[ocamlopt?]
	dev-ml/lablgtk:3=[ocamlopt?]
	!!<dev-ml/ocamlgraph-2.0.0[gtk]"

IUSE="+ocamlopt"

src_compile() {
	dune build --only-packages ocamlgraph_gtk @install || die
}
