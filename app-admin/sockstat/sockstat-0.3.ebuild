# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

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
	cd "${WORKDIR}"
	epatch "${FILESDIR}/sockstat_0.3-1.1.diff"
	cd "${S}"
	epatch debian/patches/*patch
}

src_install() {
	dobin /usr/bin
	emake DESTDIR="${D}" install
	doman ${PN}.1
	dodoc debian/control debian/changelog debian/README
}
