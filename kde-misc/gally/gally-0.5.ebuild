# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# I doubt it's compatible with Python 3
PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="teaches sign languages"
HOMEPAGE="http://launchpad.net/gally"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P/-/_}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="kde-base/pykde4[${PYTHON_USEDEP}]
	dev-python/PyQt4[phonon,${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/-/_}.orig"
