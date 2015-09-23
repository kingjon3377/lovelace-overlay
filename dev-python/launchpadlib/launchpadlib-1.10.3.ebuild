# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="Launchpad web services client library"
HOMEPAGE="https://launchpad.net/launchpadlib"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/lazr-restfulclient[${PYTHON_USEDEP}]
	dev-python/lazr-uri[${PYTHON_USEDEP}]
	dev-python/oauth[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_test() {
	esetup.py test
}
