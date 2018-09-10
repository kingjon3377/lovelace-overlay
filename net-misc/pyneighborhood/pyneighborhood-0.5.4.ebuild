# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_{6,7} )
inherit distutils-r1 eutils

DESCRIPTION="GTK+ 2 rewrite of a well-known GTK+ 1 tool LinNeighborhood"
HOMEPAGE="https://launchpad.net/pyneighborhood"
SRC_URI="http://launchpad.net/${PN}/0.5/${PV}/+download/${P}.tar.bz2"
IUSE=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"

RDEPEND="net-fs/samba[python,${PYTHON_USEDEP}]
	dev-python/pygtk[${PYTHON_USEDEP}]"
