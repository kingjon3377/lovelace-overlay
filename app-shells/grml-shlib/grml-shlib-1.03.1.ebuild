# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Generic shell library used in grml scripts"
HOMEPAGE="http://grml.org"
SRC_URI="http://deb.grml.org/pool/main/g/${PN}/${P/-1/_1}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc"

RDEPEND="sys-apps/iproute2
	sys-apps/net-tools
	sys-process/procps"
DEPEND="${RDEPEND}
	doc? ( app-text/asciidoc
	app-text/docbook-xsl-stylesheets )"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i -e 's:/usr/share/xml/docbook/stylesheet/nwalsh/manpages/docbook.xsl:/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl:g' \
		-e 's:usrdoc = $(usr)/share/doc/$(name_):'"&-${PV}:" \
		Makefile || die "sed failed"
}

src_compile() {
	use doc && default_src_compile
}

src_install() {
	if use doc; then
		emake DESTDIR="${D}" install
	else
		dodir /etc/grml
		insinto /etc/grml
		doins sh-lib
		fperms 755 /etc/grml/sh-lib
	fi
	dodoc debian/changelog debian/copyright
}
