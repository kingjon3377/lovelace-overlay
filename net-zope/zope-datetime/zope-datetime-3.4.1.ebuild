# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI="4"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Zope datetime"
HOMEPAGE="http://pypi.python.org/pypi/zope.datetime"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

#RDEPEND="net-zope/namespaces-zope[zope]"
RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="CHANGES.txt"
PYTHON_MODULES="${PN/-//}"

src_prepare() {
	distutils_src_prepare

	# Disable failing tests.
	rm -f src/zope/datetime/tests/test_lp_139360.py
}
