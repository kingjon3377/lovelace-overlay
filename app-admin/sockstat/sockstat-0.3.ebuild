# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="view detailed information about open connections"
HOMEPAGE="http://packages.debian.org/unstable/main/sockstat"
SRC_URI="mirror://debian/pool/main/s/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/10_fix-CHAR-BIT-missing.patch" \
		"${FILESDIR}/20_add-GCC-hardening.patch"
}

src_install() {
	dodir /usr/bin
	emake DESTDIR="${D}" install
	doman ${PN}.1
	dodoc "${FILESDIR}/README.Debian"
}
