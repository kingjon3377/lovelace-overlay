# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs

DESCRIPTION="schedules commands to be executed later"
HOMEPAGE="http://www.df7cb.de/projects/postpone/"
#SRC_URI="http://www.df7cb.de/projects/${PN}/packages/${P/-/_}.tar.gz"
SRC_URI="http://ftp.debian.org/debian/pool/main/p/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/trunk"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CLFAGS} ${LDFLAGS}" postpone
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc README
}
