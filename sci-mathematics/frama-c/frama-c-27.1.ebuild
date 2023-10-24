# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit opam

DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="https://frama-c.com"
NAME="Cobalt"
SRC_URI="https://frama-c.com/download/${P}-${NAME}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc gtk +ocamlopt"
RESTRICT="strip"

DEPEND="
	>=dev-lang/ocaml-4.05.0[ocamlopt?]
	!gtk? (
		>=dev-ml/ocamlgraph-1.8.5:=[ocamlopt?]
	)
	dev-ml/zarith:=
	sci-mathematics/coq:=
	sci-mathematics/ltl2ba:=
	sci-mathematics/alt-ergo:=
	dev-ml/yojson:=
	dev-ml/ppx_deriving:=
	dev-ml/ppx_deriving_yojson:=
	dev-ml/ppx_import:=
	gtk? (
		dev-ml/ocamlgraph_gtk:=[ocamlopt?]
		>=x11-libs/gtksourceview-2.8:2.0=
		>=gnome-base/libgnomecanvas-2.26
		>=dev-ml/lablgtk-2.14:=[sourceview,gnomecanvas,ocamlopt?]
	)"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/ocaml-4.05.0[ocamlopt?]
	doc? ( dev-ml/odoc )"

S="${WORKDIR}/${P}-${NAME}"

#src_configure(){
	#econf $(use_enable gtk gui)
#}

src_compile(){
	emake all DESTDIR="/" PREFIX=/usr DOCDIR="/usr/share/doc/${PF}"

	if use doc; then
		emake -j1 doc DOCDIR="/usr/share/doc/${PF}"
	fi
}

src_install() {
	dodir /usr/share/doc/${PF}
	emake install DESTDIR="${D}" PREFIX=/usr MANDIR=/usr/share/man DOCDIR="${D}/usr/share/doc/${PF}"
	mv "${D}/usr/doc" "${D}/usr/share/doc/${PF}/per-module" || die
}
