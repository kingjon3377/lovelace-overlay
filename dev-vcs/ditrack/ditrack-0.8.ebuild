# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# I doubt it's compatible with Python 3
PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="distributed issue tracker"
HOMEPAGE="http://www.ditrack.org"
SRC_URI="http://www.ditrack.org/files/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-vcs/subversion[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/DITrack-${PV}"

src_install() {
	distutils-r1_src_install
	dodoc FAQ
	dohtml -r doc
}
