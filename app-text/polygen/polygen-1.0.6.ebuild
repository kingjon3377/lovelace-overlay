# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Random phrases generator based on defined grammar files."
HOMEPAGE="http://www.polygen.org"
SRC_URI="http://www.polygen.org/dist/${P}-20040628-src.zip"
#SRC_URI="http://ftp.de.debian.org/debian/pool/main/p/polygen/polygen_1.0.6.ds2.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="+grm"

COMMON_DEPEND="dev-lang/ocaml"
RDEPEND="${COMMON_DEPEND}"
#	grm? ( app-text/polygen-grm )"
DEPEND="${COMMON_DEPEND}
	app-arch/unzip"

#S="${WORKDIR}/${P}"

src_prepare() {
	cd "${WORKDIR}"
	epatch "${FILESDIR}"/polygen_1.0.6.ds2-10.diff
	rm "${WORKDIR}/${P}.ds2/debian/patches/02-grammar-typos.patch" || die "removing unwanted patch failed"
	cd "${S}"
	epatch ../${P}.ds2/debian/patches/*
}

src_compile() {
	emake -C src
}

src_install() {
	dobin "${S}/src/polygen"
}
