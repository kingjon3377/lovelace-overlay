# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Locks important files into memory and out of swap"
HOMEPAGE="http://www.coker.com.au/projects/memlockd/"
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
	dosbin ${PN}
	insinto /etc
	# TODO: adjust default config for Gentoo
	doins ${PN}.cfg
	doman ${PN}.8
	dodoc ${PN}txt
	newdoc changes.txt ChangeLog

	# TODO: should we create a user for the init script to run as?
	doinitd "${FILESDIR}/${PN}"
}
