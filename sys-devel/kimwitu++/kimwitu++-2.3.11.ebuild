# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A (syntax-)tree-handling tool (term processor)"
HOMEPAGE="https://www2.informatik.hu-berlin.de/sam/kimwitu++"
SRC_URI="https://www2.informatik.hu-berlin.de/sam/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="+doc"

DEPEND="${RDEPEND}
	doc? ( media-gfx/transfig
	dev-texlive/texlive-langgerman )"

PATCHES=(
	"${FILESDIR}/strlen.patch"
	"${FILESDIR}/docs.patch"
)

src_prepare() {
	default
	sed -i -e 's:\(/usr/share/sgml/docbook\)/stylesheet/xsl/nwalsh/\(xhtml/docbook.xsl\):\1/xsl-stylesheets/\2:g' \
		doc/formatters/docbook2html.sh || die "sed failed"
	sed -i -e 's:\(/usr/share/sgml/docbook\)/dtd/xml/\(4.1.2/docbookx.dtd\):\1/xml-dtd-\2:g' \
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
