# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="educational BASIC programming environment for children"
HOMEPAGE="http://www.basic256.org/"
SRC_URI="mirror://sourceforge/kidbasic/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="linguas_en linguas_de linguas_es linguas_fr linguas_nl linguas_ru"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtserialport:5
	media-libs/sdl-mixer
	dev-db/sqlite:3
	app-accessibility/espeak[portaudio]"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

DOCS=( ChangeLog CONTRIBUTORS wikihelp/README.txt )

src_prepare() {
	sed -i -e 's:/usr/local:/usr:' Makefile* *pro
	sed -i -e 's@if (isinf(@if ((std::isinf)(@g' Interpreter.cpp || die
	default
}

src_configure() {
	eqmake5 BASIC256.pro
}

src_install() {
	doman debian/${PN}.1
#	for lang in en de es fr nl ru;do
#		use linguas_${lang} && dohtml -r help/${lang}
#	done
	# TODO: Don't install HTML help directly under /usr/share/${PN}/help, etc.
	INSTALL_ROOT="${D}" default
	insinto /usr/share/${PF}/html
	for lang in en de es fr nl ru;do
		use linguas_${lang} && doins -r wikihelp/help/${lang}
	done
}
