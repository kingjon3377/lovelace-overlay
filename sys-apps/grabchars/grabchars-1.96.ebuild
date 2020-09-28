# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit estack rpm toolchain-funcs

SRC_URI_BASE="ftp://ftp.informatik.uni-stuttgart.de/pub/archive/comp.sources/misc"
DESCRIPTION="Utility to read characters from the console"
HOMEPAGE="http://doc.marsu.ru/FreeBSD/upt/ch45_32.htm"
SRC_URI="http://packages.psychotic.ninja/7/base/SRPMS/${P}-2.el7.psychotic.src.rpm"

LICENSE="grabchars"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="app-shells/tcsh"

src_unpack() {
	srcrpm_unpack
}

src_compile() {
	tc-export CC
	default
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc README TODO
	docinto examples
	dodoc demo
}
