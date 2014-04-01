# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games distutils

DESCRIPTION="anagram word game"
HOMEPAGE="https://launchpad.net/pynagram"
SRC_URI="http://launchpad.net/${PN}/1.0/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install
	dodir /usr/games/bin
	mv -i "${D}/usr/bin/${PN}" "${D}/usr/games/bin" || die "fixing install path failed"
}
