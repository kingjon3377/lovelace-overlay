# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="An e-mail privacy package"
HOMEPAGE="http://packages.debian.org/premail"
SRC_URI="mirror://debian/pool/contrib/p/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="premail"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

src_prepare() {
	cd "${WORKDIR}" && mv -i ${PN}-0.45.orig ${P} || die "renaming directory failed"
	epatch "${FILESDIR}/premail_0.46-9.diff"
}

src_install() {
	ln -s premail prepost
	ln -s premail.1 prepost.1
	dobin premail prepost
	doman premail.1 prepost.1
	dodir /etc/premail
	insinto /etc/premail
	doins preferences
	dodoc doc* README
}
