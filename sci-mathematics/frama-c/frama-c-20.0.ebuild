# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="https://frama-c.com"
NAME="Calcium"
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
	dev-ml/zarith
	sci-mathematics/coq
	sci-mathematics/ltl2ba
	sci-mathematics/alt-ergo
	dev-ml/yojson
	dev-ml/ppx_deriving
	gtk? (
		|| (
			dev-ml/ocamlgraph_gtk:=[ocamlopt?]
			>=dev-ml/ocamlgraph-1.8.5[gtk?,ocamlopt?]
		)
		>=x11-libs/gtksourceview-2.8:2.0
		>=gnome-base/libgnomecanvas-2.26
		>=dev-ml/lablgtk-2.14[sourceview,gnomecanvas,ocamlopt?]
	)"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/ocaml-4.05.0[ocamlopt?]"

S="${WORKDIR}/${P}-${NAME}"

src_configure(){
	econf $(use_enable gtk gui)
}

src_compile(){
	# dependencies can not be processed in parallel,
	# this is the intended behavior.
	emake -j1 depend
	emake all top DESTDIR="/"

	if use doc; then
		emake -j1 doc doc-tgz
		tar -xzf frama-c-api.tar.gz -C doc/
	fi
}

src_install(){
	default

	if use doc; then
		docinto html
		dodoc -r doc/frama-c-api/*
	fi
}
