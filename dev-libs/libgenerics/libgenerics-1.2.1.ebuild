# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="C++ meta object runtime analyse and archiving"
HOMEPAGE="http://libgenerics.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="amd64 ~x86"
IUSE="+doc"

RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_enable doc)
}
