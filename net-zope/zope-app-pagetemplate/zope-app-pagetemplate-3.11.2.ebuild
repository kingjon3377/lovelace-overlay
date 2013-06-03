# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

inherit distutils

MY_PN=${PN/-/\.}
MY_PN=${MY_PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="PageTemplate integration for Zope 3"
HOMEPAGE="http://pypi.python.org/pypi/zope.app.pagetemplate"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# net-zope/namespaces-zope
RDEPEND="
	>=net-zope/zope-browserpage-3.12.0
	net-zope/zope-dublincore
	net-zope/zope-i18nmessageid
	net-zope/zope-interface
	net-zope/zope-pagetemplate
	net-zope/zope-security
	net-zope/zope-size
	net-zope/zope-tales
	net-zope/zope-traversing"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN//-//}"
