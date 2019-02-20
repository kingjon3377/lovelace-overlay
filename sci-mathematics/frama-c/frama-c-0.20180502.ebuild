# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eapi7-ver

DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="http://frama-c.com"
NAME="Chlorine"
SRC_URI="http://frama-c.com/download/${PN/-c/-c-$NAME}-$(ver_cut 2-).tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc gtk +ocamlopt"
RESTRICT="strip"

DEPEND="
	>=dev-lang/ocaml-4.02.3[ocamlopt?]
	>=dev-ml/ocamlgraph-1.8.5[gtk?,ocamlopt?]
	dev-ml/zarith
	sci-mathematics/coq
	sci-mathematics/ltl2ba
	sci-mathematics/alt-ergo
	gtk? (
		>=x11-libs/gtksourceview-2.8:2.0
		>=gnome-base/libgnomecanvas-2.26
		>=dev-ml/lablgtk-2.14[sourceview,gnomecanvas,ocamlopt?]
	)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN/-c/-c-$NAME}-$(ver_cut 2-)"

src_prepare(){
	touch config_file || die
	rm -f ocamlgraph.tar.gz || die
	default
}

src_configure(){
	if use gtk; then
		myconf="--enable-gui"
	else
		myconf="--disable-gui"
	fi
	econf ${myconf}
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
