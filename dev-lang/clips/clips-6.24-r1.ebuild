# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

#inherit eutils flag-o-matic autotools

DESCRIPTION="A Tool for Building Expert Systems"
HOMEPAGE="http://clipsrules.sourceforge.net/"

MY_PV="${PV/./}"
MY_PN="${PN}rules"
MY_PN2="${PN}_core_source"

SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN2}_${MY_PV}.tar.Z
		mirror://sourceforge/${MY_PN}/make_and_help_files_${MY_PV}.zip
		X?	( mirror://sourceforge/${MY_PN}/x_windows_ide_source_${MY_PV}.tar.Z )"

LICENSE="public-domain"
SLOT="0"

KEYWORDS="~x86 amd64"
IUSE="X"

RDEPEND="sys-libs/ncurses
		X? ( x11-base/xorg-server )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${PN}src/${PN}src"

src_prepare() {
	cp -v ../../makefile.gcc Makefile
	sed -i -e 's/-ltermcap/-lncurses $(CFLAGS) /' Makefile
	sed -i -e 's/-Wno-implicit/-Wno-implicit $(CFLAGS) /' Makefile
	if use X; then
		sed -i -e 's/$(INCLUDES)/$(CFLAGS)/' -e 's/$(LDFLAGS)/$(CFLAGS)/' ../../x-prjct/makefile.x
		mkdir -v xclips
		cp -v * xclips
		cp -v ../../x-prjct/makefile/makefile.x xclips/Makefile
		cp -v ../../x-prjct/color/* xclips
		cp -v ../../x-prjct/xinterface/* xclips
	fi
}

src_compile() {
	emake clips
	use X && emake -C xclips xclips
}

src_install() {
	exeinto /usr/bin
	doexe clips
	use X && doexe xclips/xclips
}
