# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DISTUTILS_SRC_TEST=setup.py

inherit distutils

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
#net-zope/zc-buildout[${PYTHON_USEDEP}]
RDEPEND="dev-python/httplib2
	dev-python/simplejson
	net-zope/zc-buildout
	dev-python/wadllib"
DEPEND="${RDEPEND}
	test? ( dev-python/lazr-restful
			dev-python/lazr-authentication
			dev-python/elementtree )"

S="${WORKDIR}/${MY_P}-${PV}"
