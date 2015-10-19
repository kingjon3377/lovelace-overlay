# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="verify electronic mail addresses"
HOMEPAGE="http://www.sepp.ee.ethz.ch/sepp/vrfy-990522-to.html"
SRC_URI="mirror://debian/pool/main/v/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/v/${PN}/${PN}_${PV}-6.debian.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	default_src_unpack
	cd "${WORKDIR}" && mv -i "${P}.orig" "${P}" || die "fixing source-dir name failed"
	mv -i debian "${P}" || die "moving debian dir into source dir failed"
}

src_prepare() {
	epatch debian/patches/*patch
	sed -i -e 's:staff:root:g' Makefile || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) COPTS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dodir /usr/bin
	emake DESTDIR="${D}" DESTBIN=/usr/bin DESTMAN="${D}/usr/share/man" STRIP= \
		install
	doman ${PN}.1
	dodoc RELEASE_NOTES debian/changelog debian/copyright
}
