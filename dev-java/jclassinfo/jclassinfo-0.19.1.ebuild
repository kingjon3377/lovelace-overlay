# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Extracts information from Java class files"
HOMEPAGE="http://jclassinfo.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

IUSE=""

COMMON_DEP=""

RDEPEND=""
DEPEND=""

src_install() {
	emake "DESTDIR=${D}" install
}
