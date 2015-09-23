# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator autotools-utils

DESCRIPTION="Pidgin plugin that provides several new sort options for the buddy list"
HOMEPAGE="https://launchpad.net/pidgin-extended-blist-sort"
SRC_URI="https://launchpad.net/${PN}/trunk/$(get_version_component_range 1-2)/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="net-im/pidgin[gtk]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog README )
