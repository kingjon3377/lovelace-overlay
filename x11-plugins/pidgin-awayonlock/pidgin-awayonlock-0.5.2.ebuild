# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

MY_PN="${PN#pidgin-}"

DESCRIPTION="Change your status when the screensaver gets activated"
HOMEPAGE="https://costela.net/projects/awayonlock"
SRC_URI="https://costela.net/files/${MY_PN}-${PV}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=net-im/pidgin-2.4.0
	dev-libs/dbus-glib"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
