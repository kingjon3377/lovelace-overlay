# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
# zope.testing.server module requires webbrowser module, so no jython
# http://bugs.jython.org/issue1762054
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy2_0 )

inherit distutils-r1

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Zope testing helpers"
HOMEPAGE="http://pypi.python.org/pypi/zope.testing"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# net-zope/namespaces-zope
RDEPEND="
	net-zope/zope-exceptions[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS="CHANGES.rst README.rst"
PYTHON_MODULES="${PN/-//}"

python_test() {
	esetup.py test
}
