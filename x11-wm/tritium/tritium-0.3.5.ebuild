# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# plwm doesn't (yet, in Gentoo) support Python 3
PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="A tiling window manager like ion3"
HOMEPAGE="https://sourceforge.net/projects/tritium/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-wm/plwm[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
