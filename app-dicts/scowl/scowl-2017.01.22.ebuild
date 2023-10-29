# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Spell Checker Oriented Word Lists"
HOMEPAGE="https://wordlist.sourceforge.net/"
SRC_URI="mirror://sourceforge/wordlist/${P}.tar.gz"

LICENSE="public-domain Princeton"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${DEPEND}"

src_compile() {
	einfo "We won't actually build this, just install it."
}

src_install() {
	insinto /usr/share/dict/${PN}
	doins final/*
	dodoc README
}
