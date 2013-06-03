# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="An explanatory dictionary of botanic and biological terms"
HOMEPAGE="http://archive.debian.net/source/sarge/ia64/leksbot"
SRC_URI="http://archive.debian.org/debian/pool/main/l/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	default_src_unpack
	cd "${WORKDIR}" && mv -i leksiko ${P} || die "renaming dir failed"
}

src_prepare() {
	cd "${WORKDIR}" && epatch "${FILESDIR}/leksbot_1.2-8.diff"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc readme debian/changelog debian/copyright
	doman debian/*.1
}
