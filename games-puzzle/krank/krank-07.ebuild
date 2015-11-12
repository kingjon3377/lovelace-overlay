# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games

DESCRIPTION="is a game of dexterity where you match stones together"
HOMEPAGE="http://krank.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="dev-python/pygame
	dev-python/pyyaml"
RDEPEND=""

src_prepare() {
	sed -i 's:KRANKPATH=`dirname $0`:KRANKPATH=/usr/share/games/krank:' ${PN} \
		|| die "sed failed"
}

src_install() {
	insinto /usr/share/games/${PN}/art
	doins -r art/*
	insinto /usr/share/games/${PN}/fonts
	doins -r fonts/*
	insinto /usr/share/games/${PN}/levels
	doins -r levels/*
	insinto /usr/share/games/${PN}/sounds
	doins -r sounds/*
	insinto /usr/share/games/${PN}/src
	doins -r src/*
	dogamesbin ${PN}
	dohtml -r html/*
	dodoc CHANGELOG.txt README
}
