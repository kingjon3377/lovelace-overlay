# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="simple personal finance"
HOMEPAGE="https://launchpad.net/wxbanker"
SRC_URI="https://github.com/mrooney/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/wxpython:3.0[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/keyring[${PYTHON_USEDEP}]
	dev-python/pyquery[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:python-2[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_install() {
	distutils-r1_src_install
	doman "${FILESDIR}/${PN}.1"
}
