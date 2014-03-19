# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Locks important files into memory and out of swap"
HOMEPAGE="http://www.coker.com.au/memlockd/"
SRC_URI="http://www.coker.com.au/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	CXX=$(tc-getCXX) CXXFLAGS="${CXXFLAGS}" emake
}

src_install() {
	dobin memlockd
	insinto /etc
	doins memlockd.cfg
	doman memlockd.8
	dodoc changes.txt
}

pkg_postinst() {
	ewarn "FIXME: We need to write an init script for this and create a user for it."
}
