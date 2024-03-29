# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Text-based front-end to Remind"
HOMEPAGE="http://pessimization.com/software/wyrd/"
SRC_URI="http://pessimization.com/software/wyrd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="unicode"

RDEPEND="
	sys-libs/ncurses:0=[unicode(+)?]
	>=app-misc/remind-03.01
	dev-ml/camlp4:=
"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-lang/ocaml-3.08"

PATCHES=( "${FILESDIR}/${P}-tinfo.patch" )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable unicode utf8)
}

src_install() {
	export STRIP_MASK="/usr/bin/wyrd"
	emake DESTDIR="${D}" install
	dodoc ChangeLog doc/manual.html
}
