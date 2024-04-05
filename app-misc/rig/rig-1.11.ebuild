# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Random identity generator"
HOMEPAGE="https://rig.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/makefile.patch"
	"${FILESDIR}/memcpy.patch"
)

src_prepare() {
	default
	sed -i -e 's@ -s @ @' Makefile || die
}

src_compile() {
	emake CC=$(tc-getCXX) CFLAGS="${CXXFLAGS}" PREFIX=/usr
}

src_install() {
	dodir /usr/bin /usr/share/man/man6
	emake PREFIX="${D}/usr" MANDIR="${D}/usr/share/man" install
}
