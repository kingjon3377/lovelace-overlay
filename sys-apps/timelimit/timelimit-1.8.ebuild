# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Simple utility to limit a process's absolute execution time"
HOMEPAGE="https://devel.ringlet.net/sysutils/timelimit/"
SRC_URI="https://devel.ringlet.net/files/sys/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="${DEPEND}"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr MANDIR=/usr/share/man/man install
	dodoc NEWS
}
