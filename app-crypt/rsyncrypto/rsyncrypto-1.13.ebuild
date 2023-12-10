# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="rsync friendly encryption"
HOMEPAGE="https://rsyncrypto.lingnu.com"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-libs/openssl-1.1.0:0
	dev-libs/argtable"
RDEPEND="${DEPEND}
	|| ( app-arch/gzip[rsyncable] >=app-arch/gzip-1.7 )"

# TODO: Isn't this basically default_src_install?
src_install() {
	emake DESTDIR="${D}" install
}
