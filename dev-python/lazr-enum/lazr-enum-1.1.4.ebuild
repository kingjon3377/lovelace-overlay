# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

MY_P="lazr.enum"

DESCRIPTION="Enums with zope.schema vocabulary support and database-friendly conveniences"
HOMEPAGE="http://launchpad.net/lazr.enum"
SRC_URI="http://launchpad.net/${MY_P}/trunk/${PV}/+download/${MY_P}-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-zope/zope-interface
	net-zope/zope-schema"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"
