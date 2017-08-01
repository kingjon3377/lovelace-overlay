# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Fault tolerant search utilities"
HOMEPAGE="http://linuxfocus.org/~guido/#whichman"
SRC_URI="http://linuxfocus.org/~guido/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	dodoc README
}
