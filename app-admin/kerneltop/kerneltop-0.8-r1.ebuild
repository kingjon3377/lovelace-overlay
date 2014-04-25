# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="shows linux kernel function usage in a style like top"
HOMEPAGE="http://www.xenotime.net/linux/kerneltop/"
SRC_URI="http://www.xenotime.net/linux/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}/kerneltop_0.8-2.1.diff"
#	mv kerneltop-0.8/debian debian && rmdir kerneltop-0.8 || die "fix failed"
}

src_compile() {
	emake CC=$(tc-getCC) "CCFLAGS=${CFLAGS}" DEBUG=y all
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc README.Debian
}
