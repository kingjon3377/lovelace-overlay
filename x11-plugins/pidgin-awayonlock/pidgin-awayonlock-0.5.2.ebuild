# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

MY_PN="${PN#pidgin-}"

DESCRIPTION="Change your status when the screensaver gets activated"
HOMEPAGE="https://costela.net/projects/awayonlock"
SRC_URI="https://costela.net/files/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-im/pidgin-2.4.0
	dev-libs/dbus-glib"
DEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"
