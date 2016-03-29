# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="rsync friendly encryption"
HOMEPAGE="http://rsyncrypto.lingnu.com"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-libs/openssl:0
	dev-libs/argtable"
RDEPEND="${DEPEND}
	|| ( app-arch/gzip[rsyncable] >=app-arch/gzip-1.7 )"

src_install() {
	emake DESTDIR="${D}" install
}
