# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib

S="${WORKDIR}/${PN}"

DESCRIPTION="Command Line Interpreter Generator"
SRC_URI="http://wsd.iitb.fhg.de/~geg/clighome/${P}.tar.gz"
HOMEPAGE="http://wsd.iitb.fhg.de/~geg/clighome/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-lang/tcl"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/clig_makefile_patch.patch"
	sed -i -e 's:)/man:)/share/man:g' -e "s:/lib/:/$(get_libdir)/:" makefile \
			|| die "sed failed"
}

src_compile() {
	emake prefix=/usr
}

src_install() {
	emake install build_root="${D}" prefix=/usr
}
