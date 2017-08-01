# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

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
RDEPEND="${DEPEND}
	app-crypt/gnupg"

src_unpack() {
	default_src_unpack
	cd "${WORKDIR}" && mv -i ${PN}-0.45.orig ${P} || die "renaming directory failed"
}

src_prepare() {
	epatch "${FILESDIR}/premail_0.46-9.diff"
}

src_install() {
	cp "${FILESDIR}/premail.1" . || die
	ln -s premail prepost
	ln -s premail.1 prepost.1
	dobin premail prepost
	doman premail.1 prepost.1
	dodir /etc/premail
	insinto /etc/premail
	doins preferences
	dodoc doc* README
	dodoc "${FILESDIR}/doc-0.46.txt" "${FILESDIR}/README.debian"
	dohtml "${FILESDIR}/doc-0.46.html"
}

pkg_postinst() {
	ewarn "If upgrading, please back up your ~/.premail/secrets and"
	ewarn "~/.premail/secrets.pgp files."
}
