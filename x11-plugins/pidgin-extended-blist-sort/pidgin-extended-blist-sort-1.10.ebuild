# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Pidgin plugin that provides several new sort options for the buddy list"
HOMEPAGE="https://github.com/kgraefe/pidgin-extended-blist-sort"
SRC_URI="https://github.com/kgraefe/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-im/pidgin[gtk]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS.md README.md CHANGES.md )

src_configure() {
	econf --disable-static
}
