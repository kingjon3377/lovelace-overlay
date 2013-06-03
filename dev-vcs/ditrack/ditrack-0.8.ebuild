# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit distutils

DESCRIPTION="distributed issue tracker"
HOMEPAGE="http://www.ditrack.org"
SRC_URI="http://www.ditrack.org/files/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-vcs/subversion"
RDEPEND="${DEPEND}"

S="${WORKDIR}/DITrack-${PV}"

src_install() {
	distutils_src_install
	dodoc FAQ
	dohtml -r doc
}
