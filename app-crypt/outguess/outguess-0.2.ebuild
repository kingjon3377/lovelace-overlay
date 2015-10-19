# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Universal Steganographic tool"
HOMEPAGE="http://www.outguess.org"
SRC_URI="http://www.outguess.org/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc ChangeLog README STIRMARK-README TODO
}
