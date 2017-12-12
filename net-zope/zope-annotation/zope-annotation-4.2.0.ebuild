# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Object annotation mechanism"
HOMEPAGE="http://pypi.python.org/pypi/zope.annotation"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# net-zope/namespaces-zope[zope,${PYTHON_USEDEP}]
RDEPEND="
	net-zope/zodb[${PYTHON_USEDEP}]
	dev-python/zope-component[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	net-zope/zope-location[${PYTHON_USEDEP}]
	net-zope/zope-proxy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN/-//}"
