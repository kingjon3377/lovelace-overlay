# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Calculate planet and star positions"
HOMEPAGE="http://www.moshier.net/"
SRC_URI="http://www.moshier.net/aa-56.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"

src_prepare() {
	edos2unix *.c *.h aa.ans read.me
	epatch "${FILESDIR}/astronomical-almanac_5.6-3.diff"
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" moonrise conjunct aa
}

src_install() {
	dobin aa conjunct moonrise
	dodir /usr/share/aa
	insinto /usr/share/aa
	doins star.cat messier.cat orbit.cat
	dodir /etc
	insinto /etc
	doins debian/aa.ini
	dodoc aa-55.xml aa.ans aa.que aa.rsp read.me readme.404
	doman debian/*.1
	dodoc debian/changelog debian/leg57-4.txt debian/leg57.log
	dodoc debian/leg57.work debian/README.*
}
