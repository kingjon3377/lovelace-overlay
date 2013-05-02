# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DISTUTILS_SRC_TEST=setup.py

inherit distutils

MY_P="lazr.uri"
DESCRIPTION="Library for parsing, manipulating, and generating URIs"
HOMEPAGE="http://launchpad.net/lazr.uri"
SRC_URI="http://launchpad.net/${MY_P}/trunk/${PV}/+download/${MY_P}-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-zope/zc-buildout"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"
