# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Generic Object Orientator"
HOMEPAGE="http://www.googoogaga.org"
SRC_URI="http://people.csail.mit.edu/jrb/goo/goo-0_155-any-dev.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-libs/boehm-gc
	dev-libs/gmp:0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/goo-0_155-any-dev

src_prepare() {
	epatch "${FILESDIR}/goo_0.155-7.patch"
}

src_install() {
	emake prefix="${D}/usr" datadir="${D}/usr/share" install
}
