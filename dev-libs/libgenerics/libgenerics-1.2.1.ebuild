# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils autotools

DESCRIPTION="C++ meta object runtime analyse and archiving"
HOMEPAGE="http://libgenerics.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="~x86 amd64"
IUSE="+doc"

RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable doc)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ${DOCS}
}
