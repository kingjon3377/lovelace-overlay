# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"

DISTUTILS_SRC_TEST=setup.py

inherit distutils

DESCRIPTION="Python library for navigating WADL files"
HOMEPAGE="http://launchpad.net/wadllib"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/lazr-uri
	dev-python/simplejson
	net-zope/zc-buildout"
RDEPEND="${DEPEND}"

RESTRICT_PYTHON_ABIS="2.[45] 3.*"
