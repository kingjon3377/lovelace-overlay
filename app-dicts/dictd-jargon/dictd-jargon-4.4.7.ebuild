# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=${PN/td-/t-}
DESCRIPTION="The Jargon File for dict"
HOMEPAGE="http://www.catb.org/~esr/jargon/index.html"
#SRC_URI="http://www.catb.org/jargon/${P##dictd-}.tar.gz
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${MY_PN}/${MY_PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/${PN:0:1}/${MY_PN}/${MY_PN}_${PV}-3.1.debian.tar.xz"
S="${WORKDIR}/${MY_PN}-${PV}.orig"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-text/dictd-1.13.0-r3"
BDEPEND="${RDEPEND}
	dev-lang/perl
	app-text/xmlto
	sys-apps/sed
	sys-apps/grep
	virtual/w3m
	sys-apps/coreutils"

src_prepare() {
	for file in $(cat "${WORKDIR}/debian/patches/series");do
		eapply "${WORKDIR}/debian/patches/${file}"
	done
	default
}

src_compile() {
	sh "${WORKDIR}/debian/jargon2dict.sh" || die
}

src_install() {
	insinto /usr/share/dict
	doins jargon.dict.dz jargon.index
	dodoc "${WORKDIR}/debian/README.Debian" ChangeLog
	newdoc "${WORKDIR}/debian/changelog" ChangeLog.Debian
}
