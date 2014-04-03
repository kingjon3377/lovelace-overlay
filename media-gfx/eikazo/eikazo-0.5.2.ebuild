# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} ) # Assuming not Python 3 compatible.

inherit distutils-r1

DESCRIPTION="graphical frontend for SANE designed for mass-scanning"
HOMEPAGE="http://eikazo.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P/e/E}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/pygtk:2[${PYTHON_USEDEP}]
	|| (
		dev-python/pillow[scanner,${PYTHON_USEDEP}]
		dev-python/imaging[scanner,${PYTHON_USEDEP}]
	)
	dev-python/pywebkitgtk[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/e/E}"
