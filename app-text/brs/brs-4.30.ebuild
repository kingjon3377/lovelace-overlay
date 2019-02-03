# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

# TODO: Rename this package to bible-kjv, and move to app-dicts
MY_PN=bible-kjv

DESCRIPTION="Bible Retrieval System: UI for the Bible"
HOMEPAGE="https://packages.debian.org/bible-kjv"
SRC_URI="mirror://debian/pool/main/${MY_PN:0:1}/${MY_PN}/${MY_PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	sed -i -e 's:\([ 	]\)make\([ 	]\):\1$(MAKE)\2:g' -e "s:-ggdb:${CFLAGS}:" \
		-e 's:-Werror::g' "${S}/Makefile" -e 's:\([ 	]\)@:\1:' || die "sed failed"
	emake clean
	default
}

src_configure() {
	tc-export CC
	default
}

src_test() {
	emake test.results
}

src_compile() {
	# Without the -j1, for some reason one file erors istead of linking.
	emake LD=$(tc-getCC) LDFLAGS="${LDFLAGS} ${CFLAGS}" DESTLIB="/usr/$(get_libdir)" all
	cd debian && $(tc-getCC) ${CFLAGS} -o randverse randverse.c || die "making randverse failed"
}

src_install() {
	dodir /usr/bin
	emake DEST="${D}/usr" DESTLIB="${D}/usr/$(get_libdir)" install
	dodoc README.* debian/README.randverse debian/notes debian/text.readme
	dobin debian/randverse
	doman debian/randverse.1
}
