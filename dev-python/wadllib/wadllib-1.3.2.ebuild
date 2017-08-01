# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# Previous versions, at least, claimed not to work with Python 3.

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="Python library for navigating WADL files"
HOMEPAGE="http://launchpad.net/wadllib"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/lazr-uri[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/zc-buildout[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_test() {
	esetup.py test
}
