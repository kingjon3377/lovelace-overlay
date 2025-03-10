# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Copyright 2011 Joseph Lehner
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

DESCRIPTION="A lightweight userspace bandwidth shaper"
HOMEPAGE="https://monkey.org/~marius/pages/trickle https://github.com/mariusae/trickle https://github.com/echiu64/trickle"
SRC_URI="https://github.com/echiu64/${PN}/archive/refs/tags/${PV/_/-}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P/_/-}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND=">=dev-libs/libevent-1.4.13:=
	>=dev-libs/libbsd-0.2.0
	net-libs/libnsl:=
	net-libs/libtirpc:="
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -i -e "s@/lib/@/$(get_libdir)/@" configure.in || die
	append-cflags $(test-flags-CC -Wno-implicit-function-declaration -Wno-incompatible-pointer-types)
	eautoreconf
}

src_install() {
	default
	insinto /etc
	if test -f trickled.conf; then
		doins trickled.conf
	else
		doins "${FILESDIR}/trickled.conf"
	fi
}
