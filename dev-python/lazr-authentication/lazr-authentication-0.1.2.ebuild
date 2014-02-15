# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DISTUTILS_SRC_TEST=setup.py

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

MY_P="lazr.authentication"

DESCRIPTION="WSGI middleware for HTTP authentication"
HOMEPAGE="https://launchpad.net/lazr.authentication"
SRC_URI="http://launchpad.net/${MY_P}/trunk/${PV}/+download/${MY_P}-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/oauth[${PYTHON_USEDEP}]
	dev-python/wsgiintercept[${PYTHON_USEDEP}]
	net-zope/zope-interface[${PYTHON_USEDEP}]"
RDEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}-${PV}"
