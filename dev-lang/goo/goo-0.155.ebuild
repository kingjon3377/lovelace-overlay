# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# TODO: Do we really still need eutils?
inherit eutils

DESCRIPTION="Generic Object Orientator"
HOMEPAGE="https://people.csail.mit.edu/jrb/goo/"
SRC_URI="https://people.csail.mit.edu/jrb/${PN}/${PN}-$(ver_rs 1- _)-any-dev.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-libs/boehm-gc
	dev-libs/gmp:0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/goo-0_155-any-dev

PATCHES=(
	"${FILESDIR}/goo_0.155-7.patch"
)

src_install() {
	emake prefix="${D}/usr" datadir="${D}/usr/share" install
	doman "${FILESDIR}/${PN}.1"
	docinto examples
	dodoc "${FILESDIR}/${PN}.emacsen-startup"
	dobin "${FILESDIR}/${PN}.sh"
}
