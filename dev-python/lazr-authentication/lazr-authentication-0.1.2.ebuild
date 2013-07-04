# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DISTUTILS_SRC_TEST=setup.py

inherit distutils

MY_P="lazr.authentication"

DESCRIPTION="WSGI middleware for HTTP authentication"
HOMEPAGE="https://launchpad.net/lazr.authentication"
SRC_URI="http://launchpad.net/${MY_P}/trunk/${PV}/+download/${MY_P}-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/httplib2
	dev-python/oauth
	dev-python/setuptools
	dev-python/wsgiintercept
	net-zope/zope-interface"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"
