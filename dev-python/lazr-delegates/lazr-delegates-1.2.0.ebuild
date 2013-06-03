# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

MY_P="lazr.delegates"

DESCRIPTION="Easily write objects that delegate behavior."
HOMEPAGE="http://launchpad.net/lazr.delegates"
SRC_URI="http://launchpad.net/${MY_P}/trunk/${PV}/+download/${MY_P}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="net-zope/zope-interface"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"
