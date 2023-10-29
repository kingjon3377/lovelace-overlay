# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs autotools

DESCRIPTION="Pidgin plugin to play typewriter sounds when buddies are typing"
HOMEPAGE="https://github.com/ragb/purple-typewriter"
SRC_URI="https://launchpad.net/pidgin-typewriter/trunk/${PV}/+download/typewriter-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="net-im/pidgin" # TODO: what USE flags?
RDEPEND="${DEPEND}"

S="${WORKDIR}/typewriter-${PV}"

src_prepare() {
	default
	tc-export CC
	eautoreconf
}

DOCS=( AUTHORS ChangeLog NEWS README )

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
