# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

DESCRIPTION="FUSE driver for Apple's APFS filesystem"
HOMEPAGE="https://github.com/sgan81/apfs-fuse"
EGIT_REPO_URI="https://github.com/sgan81/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-fs/fuse:3=
	sys-libs/zlib:=
	app-arch/bzip2:=
	sys-apps/attr"
RDEPEND="${DEPEND}"

src_prepare() {
	cat >> CMakeLists.txt <<-EOF
install(TARGETS apfs-dump RUNTIME DESTINATION "\${CMAKE_INSTALL_BINDIR}")
install(TARGETS apfs-dump-quick RUNTIME DESTINATION "\${CMAKE_INSTALL_BINDIR}")
install(TARGETS apfs LIBRARY DESTINATION "\${CMAKE_INSTALL_LIBDIR}")
install(TARGETS lzfse LIBRARY DESTINATION "\${CMAKE_INSTALL_LIBDIR}")
EOF
	sed -i -e '/^add_library/s/$/ SHARED/' CMakeLists.txt || die

	cmake_src_prepare
}
