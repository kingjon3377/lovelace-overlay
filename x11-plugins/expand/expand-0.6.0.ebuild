# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Pidgin plugin to automatically expand shortlinks "
HOMEPAGE="https://github.com/mikeage/expand"
SRC_URI="https://github.com/mikeage/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="net-im/pidgin:=
	dev-libs/glib:2"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}
