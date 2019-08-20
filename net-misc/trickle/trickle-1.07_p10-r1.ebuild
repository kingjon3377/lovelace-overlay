# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Copyright 2011 Joseph Lehner
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# TODO: Do we really still need eutils?
inherit eutils autotools

# Version without the _p suffix
MY_PV="${PV%%_p*}"
# The patch level, as in the debian repository. The +2 will remove the `_p'
MY_PL="${PV:${#MY_PV}+2}"
MY_P="${PN}-${MY_PV}"
# The debian patchset file
DEBIAN_DIFF_FILE="${PN}_${MY_PV}-${MY_PL}.diff"

DESCRIPTION="A lightweight userspace bandwidth shaper"
HOMEPAGE="https://monkey.org/~marius/pages/trickle"
SRC_URI="https://www.monkey.org/~marius/${PN}/${MY_P}.tar.gz
	mirror://debian/pool/main/${PN:0:1}/${PN}/${DEBIAN_DIFF_FILE}.gz"
RESTRICT="mirror"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-libs/libevent-1.4.13
	>=dev-libs/libbsd-0.2.0
	net-libs/libtirpc"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${WORKDIR}/${DEBIAN_DIFF_FILE}"
	"${FILESDIR}/trickle-1.07_p10-tirpc.patch"
)

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	doman debian/tricklectl.8
	# TODO: Use DOCS=() instead of manual dodoc
	dodoc debian/changelog
	insinto /etc
	doins trickled.conf
}
