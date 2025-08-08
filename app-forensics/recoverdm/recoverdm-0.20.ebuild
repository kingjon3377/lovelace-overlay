# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DEB_REV="-9"
DEB_PATCH=

DESCRIPTION="recover files/disks with damaged sectors"
#HOMEPAGE="https://www.vanheusden.com/recoverdm/"
#SRC_URI="https://www.vanheusden.com/recoverdm/${P}.tgz"
HOMEPAGE="https://packages.debian.org/recoverdm"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}${DEB_REV}${DEB_PATCH}.debian.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="${DEPEND}"

src_prepare() {
	for file in $(cat "${WORKDIR}/debian/patches/series");do
		eapply "${WORKDIR}/debian/patches/${file}"
	done
	sed -i -e 's:-O2:$(USER_CFLAGS):' Makefile || die "sed failed"
	default
}

src_compile() {
	emake CC=$(tc-getCC) USER_CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin ${PN} mergebad
	dodoc readme.txt
	doman "${WORKDIR}/debian/manpage"/*.1
}

src_test() {
	./${PN} -V || die
	./${PN} -h || die
	./mergebad -h || die
}
