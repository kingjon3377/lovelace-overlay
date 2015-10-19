# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games multilib

DESCRIPTION="The classic hand-waving multi-player X game of spellcasting:"
HOMEPAGE="http://www.eblong.com/zarf/spellcast.html"
SRC_URI="http://www.eblong.com/zarf/ftp/${PN}.tar.Z
	doc? ( mirror://debian/pool/non-free/s/spellcast-doc/spellcast-doc_1.5.tar.gz )"

LICENSE="spellcast"
SLOT="0"
KEYWORDS="amd64"
IUSE="+doc"

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_install() {
	dodir "${GAMES_BINDIR}"
	dodir /usr/share/man/man6
	dodir /usr/games/$(get_libdir)/${PN}
	emake DESTDIR="${D}" DESTMAN="${D}"/usr/share/man/man6 \
		DESTBIN="${D}"${GAMES_BINDIR} DESTLIB="${D}"$(games_get_libdir)/${PN} install
	dodoc README
	if use doc; then
		cd ../${PN}-doc-1.5 || die "cd failed"
		dohtml spellcaster.html spellcast.html/*
		dodoc debian/README.debian
	fi
}
