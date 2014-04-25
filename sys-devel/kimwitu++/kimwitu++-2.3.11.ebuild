# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A (syntax-)tree-handling tool (term processor)"
HOMEPAGE="http://www2.informatik.hu-berlin.de/sam/kimwitu++"
SRC_URI="http://www2.informatik.hu-berlin.de/sam/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="+doc"

RDEPEND=""
DEPEND="${RDEPEND}
	doc? ( media-gfx/transfig
	dev-texlive/texlive-langgerman )"

src_prepare() {
	epatch "${FILESDIR}/strlen.patch" "${FILESDIR}/docs.patch"
	sed -i -e 's:/usr/share/sgml/docbook/stylesheet/xsl/nwalsh/xhtml/docbook.xsl:/usr/share/sgml/docbook/xsl-stylesheets/xhtml/docbook.xsl:g' \
		doc/formatters/docbook2html.sh || die "sed failed"
	sed -i -e 's:/usr/share/sgml/docbook/dtd/xml/4.1.2/docbookx.dtd:/usr/share/sgml/docbook/xml-dtd-4.1.2/docbookx.dtd:g' \
		doc/kpp-main.xml || die "second sed failed"
}

src_compile() {
	default_src_compile
	use doc && emake -C doc pdf
}

src_install() {
	dobin kc++
	doman man/man1/kc++.1
	use doc && dodoc doc/manual.pdf doc/manual.tex
	dodoc AUTHORS CHANGES README src/ChangeLog src/TODO
}
