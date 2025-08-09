# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Text-based front-end to Remind"
HOMEPAGE="https://gitlab.com/wyrd-calendar/wyrd/"
SRC_URI="https://gitlab.com/${PN}-calendar/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="unicode ocamlopt test"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-ml/camlp-streams:=
	dev-ml/curses:=
	dev-ml/yojson:=
	>=app-misc/remind-03.01
"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-lang/ocaml-3.08
	test? ( dev-tcltk/expect )"

src_prepare() {
	default
	sed -i -e 's@./wyrd @_build/install/default/bin/wyrd @' Makefile || die
	sed -i -e 's@(files ChangeLog COPYING)@(files ChangeLog)@' dune || die
}

src_install() {
	dune_src_install
	mv "${ED}/usr/share/doc/${PF}/${PN}/"* "${ED}/usr/share/doc/${PF}"
	rmdir "${ED}/usr/share/doc/${PF}/${PN}"
	insinto /etc
	doins wyrdrc
}

src_test() {
	PAGER=cat emake test
}
