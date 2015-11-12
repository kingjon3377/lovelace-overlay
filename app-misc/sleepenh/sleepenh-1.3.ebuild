# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Sleep until a given date with subsecond resolution"
HOMEPAGE="http://vztech.com.br/public/utils/sleepenh/"
SRC_URI="mirror://debian/pool/main/s/sleepenh/sleepenh_1.3.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

S=${WORKDIR}/${PN}-1.2

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
}
