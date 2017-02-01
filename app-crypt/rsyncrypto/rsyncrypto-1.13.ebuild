# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="rsync friendly encryption"
HOMEPAGE="http://rsyncrypto.lingnu.com"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-libs/openssl-1.1.0:0
	dev-libs/argtable"
RDEPEND="${DEPEND}
	|| ( app-arch/gzip[rsyncable] >=app-arch/gzip-1.7 )"

src_install() {
	emake DESTDIR="${D}" install
}
