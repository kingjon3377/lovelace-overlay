# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pidgin plugin that provides several new sort options for the buddy list"
HOMEPAGE="https://launchpad.net/pidgin-extended-blist-sort"
SRC_URI="https://github.com/kgraefe/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="net-im/pidgin[gui]"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog README )

src_configure() {
	econf --disable-static
}
