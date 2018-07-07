# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs autotools

DESCRIPTION="A two-level morphology tool for natural language processing"
HOMEPAGE="https://www.issco.unige.ch/en/research/projects/MULTEXT.html https://packages.debian.org/mmorph"
SRC_URI="mirror://debian/pool/main/m/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="sys-libs/db:="
DEPEND="${RDEPEND}
	sys-devel/flex"

S="${WORKDIR}/${P}.orig"

PATCHES=(
	"${FILESDIR}/10_old-changes.patch"
	"${FILESDIR}/20_fix-spelling.patch"
	"${FILESDIR}/30_fix-configure.patch"
	"${FILESDIR}/40_add-GCC-hardening.patch"
)

src_prepare() {
	default
	eautoreconf
	tc-export CC
}

src_compile() {
	default_src_compile CFLAGS="${CFLAGS}"
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man
	emake MTHOME="${D}/usr" MANDIR="${D}/usr/share/man" install
	dodoc 00CHANGES 00COPYRIGHT 00README 00RELEASE_NOTES mmorph_v2.tex
}
