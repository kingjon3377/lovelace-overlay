# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

PYTHON_COMPAT=( python2_7 python3_{2,3} )

inherit distutils-r1

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Object life-cycle events"
HOMEPAGE="http://pypi.python.org/pypi/zope.lifecycleevent"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# net-zope/namespaces-zope[${PYTHON_USEDEP}]
RDEPEND="
	net-zope/zope-component[${PYTHON_USEDEP}]
	net-zope/zope-event[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS="CHANGES.rst README.rst"
PYTHON_MODULES="${PN/-//}"
