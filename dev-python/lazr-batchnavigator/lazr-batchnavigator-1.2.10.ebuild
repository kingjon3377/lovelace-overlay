# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

MY_P="lazr.batchnavigator"

DESCRIPTION="A library for paginating sequences of objects into batches."
HOMEPAGE="https://launchpad.net/lazr.batchnavigator"
SRC_URI="http://launchpad.net/${MY_P}/trunk/${PV}/+download/${MY_P}-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-zope/zope-cachedescriptors[${PYTHON_USEDEP}]
	net-zope/zope-publisher[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"
