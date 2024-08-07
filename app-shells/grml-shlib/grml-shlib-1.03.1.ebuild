# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Generic shell library used in grml scripts"
HOMEPAGE="https://grml.org"
SRC_URI="https://deb.grml.org/pool/main/g/${PN}/${P/-1/_1}.tar.gz"

S="${WORKDIR}/${PN}"
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

src_prepare() {
	sed -i -e 's:/usr/share/xml/docbook/stylesheet/nwalsh/manpages/docbook.xsl:/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl:g' \
		-e 's:usrdoc = $(usr)/share/doc/$(name_):'"&-${PV}:" \
		Makefile || die "sed failed"
	default
}

src_compile() {
	use doc && default_src_compile
}

src_install() {
	if use doc; then
		emake DESTDIR="${D}" install
	else
		insinto /etc/grml
		doins sh-lib
		fperms 755 /etc/grml/sh-lib
	fi
	dodoc debian/changelog debian/copyright
}
