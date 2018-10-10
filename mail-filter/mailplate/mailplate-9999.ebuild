# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# As of 2018-10-09, https://git.madduck.net certificate had expired
EGIT_REPO_URI="git://git.madduck.net/madduck/pub/code/mailplate.git"

inherit git-r3

DESCRIPTION="reformat mail drafts according to templates"
HOMEPAGE="http://madduck.net/code/mailplate/"
SRC_URI=""

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/libxslt"
RDEPEND="dev-lang/python:2.7"

src_prepare() {
	sed -i -e 's:/usr/share/sgml/docbook/stylesheet/xsl/nwalsh/manpages/docbook.xsl:/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl:g' \
		Makefile mailplate.xml || die "sed failed"
}

src_compile() {
	default_src_compile DB2MAN=/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl
}

src_install() {
	dobin mailplate
	doman mailplate.1
	dodoc config mailplate.xml README TODO
	docinto templates && dodoc templates/*
}
