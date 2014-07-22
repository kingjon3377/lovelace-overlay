# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Copyright 2011 Joseph Lehner
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

# Version without the _p suffix
MY_PV="${PV%%_p*}"
# The patch level, as in the debian repository. The +2 will remove the `_p'
MY_PL="${PV:${#MY_PV}+2}"
MY_P="${PN}-${MY_PV}"
# The debian patchset file
DEBIAN_DIFF_FILE="${PN}_${MY_PV}-${MY_PL}.diff"

DESCRIPTION="A lightweight userspace bandwidth shaper"
HOMEPAGE="http://www.monkey.org/~marius/trickle"
SRC_URI="http://www.monkey.org/~marius/${PN}/${MY_P}.tar.gz
	http://ftp.debian.org/debian/pool/main/${PN:0:1}/${PN}/${DEBIAN_DIFF_FILE}.gz"
RESTRICT="mirror"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-libs/libevent-1.4.13
	>=dev-libs/libbsd-0.2.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${WORKDIR}"/"${DEBIAN_DIFF_FILE}"
}

src_compile() {
	emake -j1
}

src_install() {
	einstall
}
