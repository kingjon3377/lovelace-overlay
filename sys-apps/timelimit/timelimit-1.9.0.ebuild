# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Simple utility to limit a process's absolute execution time"
HOMEPAGE="https://devel.ringlet.net/sysutils/timelimit/"
SRC_URI="https://devel.ringlet.net/files/sys/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-lang/perl )"

src_prepare() {
	# After running the tests, we don't need to install them
	sed -i -e '/${EXAMPLESDIR}\/tests/d' Makefile || die
	default
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	# TODO: fix pre-stripping
	emake DESTDIR="${D}" PREFIX=/usr MANDIR=/usr/share/man/man DOCSDIR="/usr/share/doc/${PF}" install
	dodoc NEWS
}
