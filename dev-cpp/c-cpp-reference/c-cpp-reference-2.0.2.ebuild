# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="C and C++ programming reference"
HOMEPAGE="http://kdevelop.org"
SRC_URI="mirror://ubuntu/pool/universe/c/${PN}/${P/ce-/ce_}.orig.tar.gz
	mirror://ubuntu/pool/universe/c/${PN}/${P/ce-/ce_}-8.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/c_cpp_reference-${PV}"

src_prepare() {
	epatch "../${P/ce-/ce_}-8.diff"
	sed -i -e 's:href="html/:href="reference:' debian/index.html
}

src_configure() {
	true
}

src_compile() {
	true
}

src_install() {
	dohtml -A \
		c,h,java,1,2,3,4,5,6,7,8,9,txt,asm,mak,lst,cpp,awk,me,ndx,typ,_c_,ini,test,unix,yabl,CC,cc,doc,wc,c1,c2,tcc,mac,csh \
		-r reference
	dohtml debian/index.html
	insinto /usr/share/doc/${P}/html/reference/C/CONTRIB/YABL
	doins reference/C/CONTRIB/YABL/yabl
}
