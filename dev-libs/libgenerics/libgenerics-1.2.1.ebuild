# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="C++ meta object runtime analyse and archiving"
HOMEPAGE="https://libgenerics.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="amd64 ~x86"
IUSE="+doc"

RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_enable doc)
}
