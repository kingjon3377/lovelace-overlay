# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PN="${PN#pidgin-}"

DESCRIPTION="Change your status when the screensaver gets activated"
HOMEPAGE="https://github.com/costela/awayonlock https://costela.net/projects/awayonlock"
SRC_URI="https://github.com/costela/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="net-im/pidgin:=
	dev-libs/glib:2
	dev-libs/dbus-glib"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
