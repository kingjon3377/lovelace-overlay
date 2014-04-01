# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

DESCRIPTION="Popular crossword game, similar to Scrabble"
HOMEPAGE="http://packages.debian.org/source/sid/scribble"
SRC_URI="mirror://debian/pool/main/s/scribble/${PN}_${PV}-1.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i -e 's/>\$/> $/g' -e 's:scribble-english$:scribble-english 2>/dev/null:' Makefile || die "sed failed"
}

src_compile() {
	# Perl script, doesn't need compilation.
	:
}

src_install() {
	emake prefix="${D}/usr" bindir="${D}/usr/games/bin" \
		mandir="${D}/usr/share/man" statedir="${D}/usr/share/games/scribble" \
		datadir="${D}/usr/share" install
}
