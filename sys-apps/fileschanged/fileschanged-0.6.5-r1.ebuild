# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Utility that reports when files have been altered"
HOMEPAGE="http://fileschanged.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND="virtual/fam"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable nls)
}

src_compile() {
	# silly cflags need to be corrected
	sed -i -e 's/-Werror//' src/Makefile || die
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog README TODO
	# make install installs the doc files in wrong directory.
	rm -rf "${D}"/usr/share/${PN}
}
