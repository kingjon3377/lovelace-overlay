# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-mod-r1

DESCRIPTION="In-kernel APFS driver"
HOMEPAGE="https://github.com/linux-apfs/linux-apfs-rw"
EGIT_REPO_URI="https://github.com/linux-apfs/linux-apfs-rw.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${DEPEND}"

DOCS=( README.rst )

src_compile() {
	unset SRCARCH ARCH
	local modlist=( apfs=fs )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
}
