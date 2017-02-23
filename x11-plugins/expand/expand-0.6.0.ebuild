# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools autotools-utils

DESCRIPTION="Pidgin plugin to automatically expand shortlinks "
HOMEPAGE="https://github.com/mikeage/expand"
SRC_URI="https://github.com/mikeage/${PN}/archive/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-im/pidgin-2.6"
DEPEND="${RDEPEND}
		virtual/pkgconfig"

src_prepare() {
	eautoreconf
}