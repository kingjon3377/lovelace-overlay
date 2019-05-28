# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

KEYWORDS="~amd64 ~x86"
DESCRIPTION="FUSE filesystem to view and edit Wikipedia articles as if they were real files"
HOMEPAGE="http://wikipediafs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="dev-python/fuse-python[${PYTHON_USEDEP}]"
