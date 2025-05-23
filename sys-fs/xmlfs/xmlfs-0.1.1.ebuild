# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A FUSE filesystem representing an XML file"
HOMEPAGE="https://github.com/halhen/xmlfs"
SRC_URI="https://github.com/halhen/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-fs/fuse:0
	dev-libs/libxml2
	dev-libs/icu:=
	sys-libs/zlib"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-implicit-function-definitions.patch" )

src_prepare() {
	sed -i -e "s@^CC = .*@CC=$(tc-getCC)@" -e "s@^CFLAGS = .*@CFLAGS=${CFLAGS}@" Makefile || die
	default
}

src_test() {
	addread /dev/fuse
	addwrite /dev/fuse
	./test.sh || die "Test failed"
}
