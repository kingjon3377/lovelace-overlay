# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Pidgin plugin that provides several new sort options for the buddy list"
HOMEPAGE="https://launchpad.net/pidgin-extended-blist-sort"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-im/pidgin[gtk]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README
}
