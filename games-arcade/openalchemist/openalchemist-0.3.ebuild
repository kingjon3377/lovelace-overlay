# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils

DESCRIPTION="NaturalChimie clone written with clanlib"
HOMEPAGE="http://www.openalchemist.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-games/clanlib:0.8[opengl,sdl]"
DEPEND="${RDEPEND}
	app-arch/zip
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${P}-gentoo.patch" )

S=${WORKDIR}/${P}-src

DOCS=( NEWS README TODO ChangeLog )

src_prepare() {
	default
	eautoreconf
}

src_install() {
	dobin build/${PN} ${PN}-config

	insinto /usr/share/${PN}
	doins -r data skins

	dodoc ${DOCS} || die "dodoc failed"

	newicon data/logo.png openalchemist.png
	newicon data/logo_svg.svg openalchemist.svg
	make_desktop_entry ${PN} OpenAlchemist ${PN}
}
