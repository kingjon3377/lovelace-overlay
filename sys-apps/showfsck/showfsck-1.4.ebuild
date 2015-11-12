# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Show the number of reboots before mandatory ext2/3/4 fsck"
HOMEPAGE="http://packages.ubuntu.com/precise/showfsck"
SRC_URI="mirror://ubuntu/pool/universe/s/showfsck/${P/-/_}ubuntu4.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	sys-fs/e2fsprogs"

src_unpack() {
	default
	pushd "${WORKDIR}"
	mv showfsck-1.4ubuntu3 ${P}
}

src_install() {
	dosbin ${PN}
	doman ${PN}.8
	dodoc debian/changelog
}
