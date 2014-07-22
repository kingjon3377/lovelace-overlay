# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Identify what's using up virtual memory"
HOMEPAGE="http://packages.debian.org/memstat"
SRC_URI="mirror://debian/pool/main/m/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}tool"

src_prepare() {
	sed -i -e "s:^CFLAGS =.*:CFLAGS = ${CFLAGS} ${LDFLAGS}:" Makefile || die "sed failed"
}

src_compile() {
	emake DEB_BUILD_OPTIONS=nostrip
}

src_install() {
	dodir /usr/bin /etc
	emake DESTDIR="${D}" install
	doman ${PN}.1
	dodoc ${PN}-tutorial.txt debian/copyright
}
