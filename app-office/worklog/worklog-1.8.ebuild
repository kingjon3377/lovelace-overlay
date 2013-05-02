# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Keep Track of Time worked on Projects"
HOMEPAGE="http://www.truxton.com/~trux/software/"
SRC_URI="http://ibiblio.org/pub/linux/apps/reminder/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_compile() {
	emake CFLAGS="${CFLAGS} -DVERSIONS=\"1.8\""
}

src_install() {
#	chmod a+x worklog
	dobin worklog
	doman worklog.1
	dodoc projects README TODO worklog.lsm
}
