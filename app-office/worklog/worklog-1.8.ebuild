# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Keep Track of Time worked on Projects"
HOMEPAGE="http://www.truxton.com/~trux/software/"
SRC_URI="http://ibiblio.org/pub/linux/apps/reminder/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-libs/ncurses:0"
RDEPEND="${DEPEND}"

src_compile() {
	emake CFLAGS="${CFLAGS} -DVERSIONS=\"1.8\""
}

src_install() {
#	chmod a+x worklog
	dobin ${PN}
	doman ${PN}.1
	dodoc projects README TODO ${PN}.lsm
}
