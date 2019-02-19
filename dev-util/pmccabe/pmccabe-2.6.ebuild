# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="McCabe-style function complexity and line counting for C and C++"
HOMEPAGE="https://people.debian.org/~bame/pmccabe/"
SRC_URI="mirror://debian/pool/main/p/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i \
		-e 's|$(PROGS) test|$(PROGS)|' \
		-e 's|-o root -g root||' \
		Makefile || die "sed failed"
	default
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

DOCS=( ChangeLog TODO )
