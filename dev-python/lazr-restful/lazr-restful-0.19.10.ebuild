# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

MY_P="lazr.restful"

DESCRIPTION="Publish Python objects as RESTful resources over HTTP"
HOMEPAGE="https://launchpad.net/lazr.restful"
SRC_URI="http://launchpad.net/${MY_P}/trunk/${PV}/+download/${MY_P}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-zope/grokcore-component[${PYTHON_USEDEP}]
	dev-python/lazr-batchnavigator[${PYTHON_USEDEP}]
	dev-python/lazr-delegates[${PYTHON_USEDEP}]
	dev-python/lazr-enum[${PYTHON_USEDEP}]
	dev-python/lazr-lifecycle[${PYTHON_USEDEP}]
	dev-python/martian[${PYTHON_USEDEP}]
	dev-python/van-testing[${PYTHON_USEDEP}]
	net-zope/zope-app-pagetemplate[${PYTHON_USEDEP}]
	net-zope/zope-configuration[${PYTHON_USEDEP}]
	net-zope/zope-pagetemplate[${PYTHON_USEDEP}]
	net-zope/zope-security[${PYTHON_USEDEP}]
	net-zope/zope-traversing[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"
