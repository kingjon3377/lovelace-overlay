# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Spell Checker Oriented Word Lists"
HOMEPAGE="http://wordlist.sourceforge.net/"
SRC_URI="mirror://sourceforge/wordlist/${P}.tar.gz"

LICENSE="public-domain Princeton"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	einfo "We won't actually build this, just install it."
}

src_install() {
	dodir /usr/share/dict/${PN}
	insinto /usr/share/dict/${PN}
	doins final/*
	dodoc README
}