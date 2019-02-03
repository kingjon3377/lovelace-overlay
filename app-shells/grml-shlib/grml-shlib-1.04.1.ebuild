# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Generic shell library used in grml scripts"
HOMEPAGE="http://grml.org"
SRC_URI="https://github.com/grml/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
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
		dodir /etc/grml
		insinto /etc/grml
		doins sh-lib
		fperms 755 /etc/grml/sh-lib
		dodoc TODO
	fi
	dodoc debian/changelog debian/copyright
}
