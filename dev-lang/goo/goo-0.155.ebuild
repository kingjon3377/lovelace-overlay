# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DEBIAN_PATCH_V=ds-4

DESCRIPTION="Generic Object Orientator"
HOMEPAGE="https://people.csail.mit.edu/jrb/goo/"
SRC_URI="https://people.csail.mit.edu/jrb/${PN}/${PN}-$(ver_rs 1- _)-any-dev.tar.gz
	mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}+${DEBIAN_PATCH_V}.debian.tar.xz"

S=${WORKDIR}/goo-0_155-any-dev
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="dev-libs/boehm-gc
	dev-libs/gmp:0="
DEPEND="${RDEPEND}
	app-arch/xz-utils"

PATCHES=(
	"debian/patches/debian-changes.patch"
)

src_prepare() {
	mv ../debian/ . || die
	mv debian/patches/debian-changes{,.patch} || die
	default
	sed -i -e "s@/doc/goo/@/doc/${PF}/@" doc/Makefile.in || die
	eautoreconf
}

src_install() {
	emake prefix="${D}/usr" datadir="${D}/usr/share" install
	mv "${D}/usr/bin/${PN}" "${D}/usr/bin/g2c"
	doman debian/${PN}.1
	docinto examples
	dodoc "${FILESDIR}/${PN}.emacsen-startup"
	newbin debian/${PN}.sh ${PN}
}
