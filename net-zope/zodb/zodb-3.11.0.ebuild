# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"
DISTUTILS_SRC_TEST="setup.py"

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

MY_PN="ZODB3"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope Object Database: object database and persistence"
HOMEPAGE="http://pypi.python.org/pypi/ZODB3 https://launchpad.net/zodb"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/manuel[${PYTHON_USEDEP}]
	>=net-zope/transaction-1.1.0[${PYTHON_USEDEP}]
	net-zope/zc-lockfile[${PYTHON_USEDEP}]
	net-zope/zconfig[${PYTHON_USEDEP}]
	net-zope/zdaemon[${PYTHON_USEDEP}]
	net-zope/zope-event[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	net-zope/zope-testing[${PYTHON_USEDEP}]
	!media-libs/FusionSound"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="doc/* HISTORY.txt README.txt"
PYTHON_MODULES="BTrees persistent ZEO ZODB"
