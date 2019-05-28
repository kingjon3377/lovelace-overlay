# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit distutils-r1

DESCRIPTION="Extract and browse the URLs contained in an email"
HOMEPAGE="https://github.com/firecat53/urlscan https://packages.debian.org/urlscan"
SRC_URI="mirror://debian/pool/main/u/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/urwid[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-skip-COPYING.patch" )

src_prepare() {
	default
	sed -i -e "s@share/doc/urlscan@share/doc/${PF}@" setup.py || die
}

src_install() {
	distutils-r1_src_install
	doman ${PN}.1
}
