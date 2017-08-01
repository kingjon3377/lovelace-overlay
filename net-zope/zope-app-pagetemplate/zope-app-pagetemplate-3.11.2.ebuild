# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

MY_PN=${PN/-/\.}
MY_PN=${MY_PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="PageTemplate integration for Zope 3"
HOMEPAGE="http://pypi.python.org/pypi/zope.app.pagetemplate"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# net-zope/namespaces-zope[${PYTHON_USEDEP}]
RDEPEND="
	>=net-zope/zope-browserpage-3.12.0[${PYTHON_USEDEP}]
	net-zope/zope-dublincore[${PYTHON_USEDEP}]
	net-zope/zope-i18nmessageid[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	net-zope/zope-pagetemplate[${PYTHON_USEDEP}]
	net-zope/zope-security[${PYTHON_USEDEP}]
	net-zope/zope-size[${PYTHON_USEDEP}]
	net-zope/zope-tales[${PYTHON_USEDEP}]
	net-zope/zope-traversing[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN//-//}"
