# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Show the number of reboots before mandatory ext2/3/4 fsck"
HOMEPAGE="https://packages.ubuntu.com/showfsck"
SRC_URI="mirror://ubuntu/pool/universe/s/showfsck/${P/-/_}ubuntu4.tar.gz"

S="${WORKDIR}/${P}ubuntu3"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="${DEPEND}
	sys-fs/e2fsprogs"

src_install() {
	dosbin ${PN}
	doman ${PN}.8
	dodoc debian/changelog
	# TODO: Make an openrc init script, using the Ubuntu one as inspiration.
}
