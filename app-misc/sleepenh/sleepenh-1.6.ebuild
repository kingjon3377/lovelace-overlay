# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Sleep until a given date with subsecond resolution"
HOMEPAGE="http://vztech.com.br/public/utils/sleepenh/"
SRC_URI="mirror://debian/pool/main/s/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( changelog )

PATCHES=( "${FILESDIR}/0001-makefile-add-extra-cflags.patch" )

src_compile() {
	emake EXTRA_CFLAGS="${CFLAGS}" CC=$(tc-getCC)
}