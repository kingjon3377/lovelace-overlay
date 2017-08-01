# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Simple utility to limit a process's absolute execution time"
HOMEPAGE="http://devel.ringlet.net/sysutils/timelimit/"
SRC_URI="http://devel.ringlet.net/sysutils/timelimit/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr MANDIR=/usr/share/man/man install
	dodoc NEWS
}
