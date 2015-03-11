# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Fast C++ dependency generator"
HOMEPAGE="http://www.irule.be/bvh/c++/fastdep/"
SRC_URI="http://www.irule.be/bvh/c++/fastdep/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/fastdep.patch"
#	sed -i -e 's/fstat/::fstat/' MappedFile.cc || die "sed failed"
}

src_install() {
	dobin fastdep
	dodoc AUTHORS CHANGELOG README TODO
	dohtml doc/*html
	dodoc doc/fastdep.pdf doc/fastdep.sgml doc/fastdep.docbook
	doman doc/fastdep.1
}
