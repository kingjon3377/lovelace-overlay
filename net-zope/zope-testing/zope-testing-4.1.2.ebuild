# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5"
# zope.testing.server module requires webbrowser module.
# http://bugs.jython.org/issue1762054
PYTHON_TESTS_RESTRICTED_ABIS="*-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Zope testing helpers"
HOMEPAGE="http://pypi.python.org/pypi/zope.testing"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# net-zope/namespaces-zope
RDEPEND="
	net-zope/zope-exceptions"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

DOCS="CHANGES.rst README.rst"
PYTHON_MODULES="${PN/-//}"
