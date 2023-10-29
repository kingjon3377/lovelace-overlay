# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="view detailed information about open connections"
HOMEPAGE="https://github.com/alteholz/sockstat https://packages.debian.org/unstable/main/sockstat"
SRC_URI="https://github.com/alteholz/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${DEPEND}"

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
