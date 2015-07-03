# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2

DESCRIPTION="educational BASIC programming environment for children"
HOMEPAGE="http://www.basic256.org/"
SRC_URI="mirror://sourceforge/kidbasic/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="linguas_en linguas_de linguas_es linguas_fr linguas_nl linguas_ru"

RDEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4
	media-libs/sdl-mixer
	dev-db/sqlite:3
	app-accessibility/espeak[portaudio]"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

src_prepare() {
	sed -i -e 's:/usr/local:/usr:' Makefile* *pro
	default
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	for lang in en de es fr nl ru;do
		use linguas_${lang} && dohtml -r help/${lang}
	done
	dodoc help/README.txt
}
