# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_4 ) # python2_6 python3_2 python3_3

inherit distutils-r1

MY_P="lazr.enum"

DESCRIPTION="Enums with zope.schema vocabulary support and database-friendly conveniences"
HOMEPAGE="http://launchpad.net/lazr.enum"
SRC_URI="http://launchpad.net/${MY_P}/trunk/${PV}/+download/${MY_P}-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/zope-interface[${PYTHON_USEDEP}]
	net-zope/zope-schema[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"
