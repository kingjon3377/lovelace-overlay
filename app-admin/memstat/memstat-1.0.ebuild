# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Identify what's using up virtual memory"
HOMEPAGE="https://packages.debian.org/memstat"
SRC_URI="mirror://debian/pool/main/m/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}tool"

src_prepare() {
	sed -i -e "s:^CFLAGS =.*:CFLAGS = ${CFLAGS} ${LDFLAGS}:" \
		-e 's/-p -s -o/-p    -o/' Makefile || die "sed failed"
	tc-export CC
	default
}

DOCS=( ${PN}-tutorial.txt debian/copyright )

src_install() {
	dodir /usr/bin /etc
	doman ${PN}.1
	default
}
