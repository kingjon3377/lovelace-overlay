# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="view detailed information about open connections"
HOMEPAGE="https://packages.debian.org/unstable/main/sockstat"
SRC_URI="mirror://debian/pool/main/s/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/10_fix-CHAR-BIT-missing.patch"
	"${FILESDIR}/20_add-GCC-hardening.patch"
	"${FILESDIR}/30_cross.patch"
	"${FILESDIR}/40_handle-missing-files.patch"
	"${FILESDIR}/50_handle-unknown-user.patch"
)

DOCS=( "${FILESDIR}/README.Debian" )

src_prepare() {
	tc-export CC
	default
}

src_install() {
	dodir /usr/bin
	default
	doman ${PN}.1
}
