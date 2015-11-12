# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils toolchain-funcs autotools

DESCRIPTION="A two-level morphology tool for natural language processing"
HOMEPAGE="http://packages.debian.org/mmorph"
SRC_URI="mirror://debian/pool/main/m/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="sys-libs/db:="
DEPEND="${RDEPEND}
	sys-devel/flex"

src_prepare() {
	cd "${WORKDIR}" && mv -i ${P}.orig ${P} || die "renaming source dir failed"
	epatch "${FILESDIR}/mmorph_2.3.4.2-12.diff"
	cd "${S}"
	epatch "${FILESDIR}"/errlist.patch
	eautoreconf
}

src_configure() {
	default_src_configure CC=$(tc-getCC)
}

src_compile() {
	default_src_compile CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man
	emake MTHOME="${D}/usr" MANDIR="${D}/usr/share/man" install
	dodoc 00CHANGES 00COPYRIGHT 00README 00RELEASE_NOTES mmorph_v2.tex
}
