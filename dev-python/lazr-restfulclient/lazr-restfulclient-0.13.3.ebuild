# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DISTUTILS_SRC_TEST=setup.py

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

MY_P="lazr.restfulclient"

DESCRIPTION="client for lazr.restful-based web services"
HOMEPAGE="https://launchpad.net/lazr.restfulclient"
SRC_URI="http://launchpad.net/${MY_P}/trunk/${PV}/+download/${MY_P}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

# Doc- and example-tests are failing, but apparently not others.
#RESTRICT="test"

# zc-buildout hasn't migrated to distutils-r1 yet, but we won't wait for it.
RDEPEND="dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/zc-buildout[${PYTHON_USEDEP}]
	dev-python/wadllib[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/lazr-restful[${PYTHON_USEDEP}]
			dev-python/lazr-authentication[${PYTHON_USEDEP}]
			dev-python/elementtree[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}-${PV}"

python_test() {
	esetup.py test
}
