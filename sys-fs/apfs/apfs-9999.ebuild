# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-mod

DESCRIPTION="In-kernel APFS driver"
HOMEPAGE="https://github.com/linux-apfs/linux-apfs-rw"
SRC_URI=""
EGIT_REPO_URI="https://github.com/linux-apfs/linux-apfs-rw.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

MODULE_NAMES="apfs(fs)"
BUILD_TARGETS="clean default"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=( CONTRIBUTING README.rst )

src_compile() {
	unset SRCARCH ARCH
	emake KERNEL_DIR="${KERNEL_DIR}"
}

src_install() {
	linux-mod_src_install
	dodoc "${DOCS[@]}"
}
