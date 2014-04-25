# Copyright 1999-2011 Gentoo Foundation
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

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	cd "${WORKDIR}" && epatch "${FILESDIR}/wotsap_0.7-2.diff"
	cd "${S}"
	sed -i -e 's:/usr/share/xml/docbook/stylesheet/nwalsh/manpages/docbook.xsl:/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl:g' \
		man/* || die "sed failed"
}

src_compile() {
	default_src_compile DB2MAN=/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl
}

src_install() {
	dobin wotsap pks2wot dl-latest.wot
	dodoc wotfileformat.txt ChangeLog
	doman man/wotsap.1
}
