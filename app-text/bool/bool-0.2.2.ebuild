# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Utility for matching boolean queries in text or html files"
HOMEPAGE="http://www.gnu.org/software/bool/bool.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RESTRICT="primaryuri"

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/xz-utils"

src_prepare() {
	default_src_prepare
	epatch "${FILESDIR}"/*patch
}

src_install() {
	dobin src/bool
	doman doc/bool.1
	dodoc NEWS ChangeLog README
}
