# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="rsync friendly encryption"
HOMEPAGE="https://rsyncrypto.lingnu.com"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-libs/openssl:0
	dev-libs/argtable"
RDEPEND="${DEPEND}
	|| ( app-arch/gzip[rsyncable] >=app-arch/gzip-1.7 )"
