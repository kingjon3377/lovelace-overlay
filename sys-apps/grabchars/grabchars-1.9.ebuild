# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

SRC_URI_BASE="ftp://ftp.informatik.uni-stuttgart.de/pub/archive/comp.sources/misc"
DESCRIPTION="Utility to read characters from the console"
HOMEPAGE="http://doc.marsu.ru/FreeBSD/upt/ch45_32.htm"
SRC_URI="${SRC_URI_BASE}/${P}/part01.gz -> ${P}-part01.shar.gz
	${SRC_URI_BASE}/${P}/part02.gz -> ${P}-part02.shar.gz"

LICENSE="grabchars"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=""
DEPEND="${DEPEND}
	app-arch/sharutils
	app-shells/tcsh"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mkdir "${P}"
	unshar -d "${P}" *.shar || die
}

src_prepare() {
	cp "${FILESDIR}/Makefile" "${S}/Makefile" || die
	epatch "${FILESDIR}/headers.patch"
}

src_compile() {
	tc-export CC
	export USER_CFLAGS="${CFLAGS}"
	default
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc README TODO
	docinto examples
	dodoc demo
	docinto web
	dodoc web/*
}
