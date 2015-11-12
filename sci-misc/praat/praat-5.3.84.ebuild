# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils versionator toolchain-funcs

# FIXME: for versions with last part < 10 pad with zeroes
# e.g 4 => 4000, 5.1 => 5100, 5.2.7 => 5207.
MY_PV=$(delete_all_version_separators)

DESCRIPTION="Speech analysis and synthesis"
SRC_URI="http://www.fon.hum.uva.nl/praat/${PN}${MY_PV}_sources.tar.gz"
HOMEPAGE="http://www.fon.hum.uva.nl/praat/"
DEPEND="|| ( ( x11-libs/libXmu
			x11-libs/libXt
			x11-libs/libX11
			x11-libs/libICE
			x11-libs/libXext
			x11-libs/libSM
			x11-libs/libXp
			x11-libs/gtk+:2
		)
		virtual/x11
	)
	x11-libs/motif:0
	media-libs/alsa-lib"
RDEPEND="${DEPEND}"
KEYWORDS="~amd64"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/sources_${MY_PV}"

src_prepare() {
	# TODO: following line should be updated for non-linux etc. builds
	# (Flammie does not have testing equipment)
	cp "${S}/makefiles/makefile.defs.linux.alsa" "${S}/makefile.defs"
	sed -i -e 's:^CC = gcc:CC = $(USER_CC):' \
		-e 's:^CXX = g++:CXX = $(USER_CXX):' \
		-e 's:^AR = ar:AR = $(USER_AR):' \
		-e 's:^LINK = g++:LINK = $(USER_LINK):' \
		-e '/^CFLAGS/s/ -O[0-9] / /' \
		-e '/^CFLAGS/s/ -g\([0-9]\|\) / /' \
		"${S}/makefile.defs"
}

src_compile() {
	emake USER_CC="$(tc-getCC) ${CFLAGS}" USER_CXX="$(tc-getCXX) ${CXXFLAGS}" \
		"USER_AR=$(tc-getAR)" "USER_LINK=$(tc-getCXX) ${LDFLAGS}"
}

src_install() {
	dobin praat
#	dodir /usr/share/${PN}
#	insinto /usr/share/${PN}
#	doins test/*
#	dodir /usr/share/${PN}/texio
#	insinto /usr/share/${PN}/texio
#	doins test/texio/*
#	dodir /usr/share/${PN}/logisticRegression
#	insinto /usr/share/${PN}/logisticRegression
#	doins test/logisticRegression/*
}
