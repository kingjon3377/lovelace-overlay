# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Sleep until a given date with subsecond resolution"
HOMEPAGE="https://packages.debian.org/sleepenh"
SRC_URI="mirror://debian/pool/main/s/${PN}/${PN}_${PV}.orig.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="app-arch/xz-utils"

DOCS=( changelog )

PATCHES=(
	"${FILESDIR}/${P}-dont-compress-manpage.patch"
	"${FILESDIR}/${P}-accept-PV.patch"
)

src_compile() {
	emake EXTRA_CFLAGS="${CFLAGS}" CC=$(tc-getCC) PV=${PV}
}
