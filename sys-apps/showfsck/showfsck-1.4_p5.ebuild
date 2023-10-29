# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Show the number of reboots before mandatory ext2/3/4 fsck"
HOMEPAGE="https://packages.ubuntu.com/showfsck"
SRC_URI="mirror://ubuntu/pool/universe/s/showfsck/${PN}_$(ver_cut 1-2)ubuntu$(ver_cut 4).tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sys-fs/e2fsprogs"
BDEPEND="app-arch/xz-utils"

S="${WORKDIR}/${PN}-$(ver_cut 1-2)ubuntu$(ver_cut 4)"

src_install() {
	dosbin ${PN}
	doman ${PN}.8
	dodoc debian/changelog
	# TODO: Make an openrc init script, using the Ubuntu one as inspiration.
}
