# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Parser for expressions concerning physical values"
HOMEPAGE="http://packages.debian.org/sid/units-filter"
SRC_URI="mirror://debian/pool/main/u/${PN}/${P/r-/r_}.orig.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="app-text/recode"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	sys-devel/bison
	sys-devel/flex"

src_unpack() {
	default_src_unpack
	mv -i "${WORKDIR}/${P}.orig" "${WORKDIR}/${P}" || die "fixing directory failed"
}

src_prepare() {
	sed -i -e 's:grep -q Debian /etc/issue:true:' src/Makefile || die "fixing Makefile failed"
	sed -i -e 's:/usr/share/xml/docbook/stylesheet/nwalsh/manpages/docbook.xsl:/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl:g' \
		-e 's:/usr/share/sgml/docbook/stylesheet/xsl/nwalsh/manpages/docbook.xsl:/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl:g' \
		manpage.xml Makefile || die "Fixing XSL reference failed"
	emake -C src clean
}

src_compile() {
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) CFLAGS="${CFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" -C src
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) CFLAGS="${CFLAGS}" \
		CXXFLAGS="${CXXFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc LISEZMOI README
}
