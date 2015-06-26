# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit games distutils-r1

DESCRIPTION="anagram word game"
HOMEPAGE="https://launchpad.net/pynagram"
SRC_URI="http://launchpad.net/${PN}/1.0/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/PyQt4[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_install() {
	distutils-r1_src_install
	dodir /usr/games/bin
	mv -i "${D}/usr/bin/${PN}" "${D}/usr/games/bin" || die "fixing install path failed"
}
