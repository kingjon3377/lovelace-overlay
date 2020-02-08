# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Utility that reports when files have been altered"
HOMEPAGE="https://savannah.nongnu.org/projects/fileschanged/"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND="virtual/fam"
RDEPEND="${DEPEND}"

DOCS=( ChangeLog README TODO AUTHORS )

src_prepare() {
	sed -i -e 's@-Werror@@' src/Makefile.in || die
	sed -i -e 's;pkgdatadir = $(datadir)/@PACKAGE@;pkgdatadir = $(datadir)/doc/@PACKAGE@-'"${PVR}"';' \
		Makefile.in || die
	default
}

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	default
	rm -f "${D}/usr/share/doc/${PF}/INSTALL"*
}
