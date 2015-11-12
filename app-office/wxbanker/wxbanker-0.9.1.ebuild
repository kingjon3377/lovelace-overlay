# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="simple personal finance"
HOMEPAGE="https://launchpad.net/wxbanker"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/wxpython:2.8[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:python-2[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
