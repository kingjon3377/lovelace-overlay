# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="The Zope publisher publishes Python objects on the web."
HOMEPAGE="http://pypi.python.org/pypi/zope.publisher"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# net-zope/namespaces-zope[${PYTHON_USEDEP}]
RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	net-zope/zope-browser[${PYTHON_USEDEP}]
	net-zope/zope-component[${PYTHON_USEDEP}]
	net-zope/zope-configuration[${PYTHON_USEDEP}]
	net-zope/zope-contenttype[${PYTHON_USEDEP}]
	net-zope/zope-event[${PYTHON_USEDEP}]
	net-zope/zope-exceptions[${PYTHON_USEDEP}]
	net-zope/zope-i18n[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	net-zope/zope-location[${PYTHON_USEDEP}]
	net-zope/zope-proxy[${PYTHON_USEDEP}]
	net-zope/zope-schema[${PYTHON_USEDEP}]
	net-zope/zope-security[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	app-arch/unzip"

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN/.//}"
