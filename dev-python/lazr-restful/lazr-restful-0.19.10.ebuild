# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

MY_P="lazr.restful"

DESCRIPTION="Publish Python objects as RESTful resources over HTTP"
HOMEPAGE="https://launchpad.net/lazr.restful"
SRC_URI="http://launchpad.net/${MY_P}/trunk/${PV}/+download/${MY_P}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-zope/grokcore-component
	dev-python/lazr-batchnavigator
	dev-python/lazr-delegates
	dev-python/lazr-enum
	dev-python/lazr-lifecycle
	dev-python/martian
	dev-python/van-testing
	net-zope/zope-app-pagetemplate
	net-zope/zope-configuration
	net-zope/zope-pagetemplate
	net-zope/zope-security
	net-zope/zope-traversing"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"
