# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="OpenPGP Web of Trust analyzer and pathfinder"
HOMEPAGE="http://www.lysator.liu.se/~jc/wotsap/index.html"
SRC_URI="mirror://debian/pool/main/w/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

COMMON_DEPEND=""
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt"
RDEPEND="${COMMON_DEPEND}
	net-misc/wget
	|| ( media-fonts/dejavu media-fonts/freefont )"

src_prepare() {
	epatch "${FILESDIR}/wotsap_0.7-2.diff"
	mkdir -p man
	cp "${FILESDIR}/${P}.dbk" man/${PN}.dbk
	cp "${FILESDIR}/${P}-man-Makefile" man/Makefile
	cp "${FILESDIR}/${P}-Makefile" Makefile
}

src_install() {
	dobin wotsap pks2wot
	newbin "${FILESDIR}/${P}-dl-latest.wot" dl-latest.wot
	dodoc wotfileformat.txt ChangeLog
	doman man/wotsap.1
}
