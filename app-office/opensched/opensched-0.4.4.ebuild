# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="tool for project management"
HOMEPAGE="http://opensched.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-texlive/texlive-latexextra"
RDEPEND="${DEPEND}"

src_prepare() {
	cd "${WORKDIR}" && epatch "${FILESDIR}/opensched_0.4.4-6.diff"
	cd "${S}" && epatch debian/patches/*patch "${FILESDIR}/samples.patch"
	default_src_prepare
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" CXX=$(tc-getCXX) CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog ChangeLog.0 NEWS README TODO USAGE
	docinto gui
	dodoc gui/README
	dohtml gui/*html
	docinto examples/sample
	dohtml examples/sample/*
	dodoc examples/sample/*.sched examples/sample/*.tex examples/sample/*.pdf
	docinto examples/toffee
	dohtml examples/toffee/*
	dodoc examples/toffee/*.sched examples/toffee/*.tex examples/toffee/*.pdf examples/toffee/*.xml
}
