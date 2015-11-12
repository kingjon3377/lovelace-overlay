# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs autotools eutils

DESCRIPTION="Pidgin plugin to play typewriter sounds when buddies are typing"
HOMEPAGE="https://github.com/ragb/purple-typewriter"
SRC_URI="https://github.com/ragb/purple-typewriter/archive/0.1.4.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-im/pidgin" # TODO: what USE flags?
RDEPEND="${DEPEND}"

src_prepare() {
	tc-export CC
	eautoreconf
}

DOCS=( AUTHORS ChangeLog NEWS README )

src_install() {
	emake DESTDIR="${D}" install
	dodoc "${DOCS[@]}"
	prune_libtool_files --modules
}
