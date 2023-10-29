# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs edos2unix

DESCRIPTION="Calculate planet and star positions"
HOMEPAGE="http://www.moshier.net/"
# TODO: Use $PV in SRC_URI, just removing the version separator
SRC_URI="http://www.moshier.net/aa-56.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"

S="${WORKDIR}/aa-$(ver_rs 1- '')"

# TODO: Update to current Debian patch version
PATCHES=( "${FILESDIR}/astronomical-almanac_5.6-3.diff" )

src_prepare() {
	edos2unix *.c *.h aa.ans read.me
	default
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" moonrise conjunct aa
}

src_install() {
	dobin aa conjunct moonrise
	insinto /usr/share/aa
	doins star.cat messier.cat orbit.cat
	insinto /etc
	doins "${FILESDIR}/aa.ini"
	doman "${FILESDIR}"/*.1
	dodoc aa-55.xml aa.ans aa.que aa.rsp read.me readme.404 "${FILESDIR}"/changelog \
		"${FILESDIR}/leg57-4.txt" "${FILESDIR}/leg57.log" "${FILESDIR}/leg57.work" \
		"${FILESDIR}/"README.*
}
