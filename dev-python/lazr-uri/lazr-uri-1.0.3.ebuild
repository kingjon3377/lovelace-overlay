# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DISTUTILS_SRC_TEST=setup.py

# zc-buildout restricts Python 3, so we do too.
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_P="lazr.uri"
DESCRIPTION="Library for parsing, manipulating, and generating URIs"
HOMEPAGE="http://launchpad.net/lazr.uri"
SRC_URI="http://launchpad.net/${MY_P}/trunk/${PV}/+download/${MY_P}-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#zc-buildout hasn't migrated to distutils-r1 yet, but we're not going to let that stop us.
#DEPEND="net-zope/zc-buildout[${PYTHON_USEDEP}]"
DEPEND="net-zope/zc-buildout"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"
