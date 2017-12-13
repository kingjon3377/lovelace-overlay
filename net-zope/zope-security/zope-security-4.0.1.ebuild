# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5

PYTHON_COMPAT=( python2_{6,7} python3_{3,4} )

inherit distutils-r1

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Zope Security Framework"
HOMEPAGE="http://pypi.python.org/pypi/zope.security"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# net-zope/namespaces-zope
RDEPEND="
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/restrictedpython[${PYTHON_USEDEP}]
	dev-python/zope-component[${PYTHON_USEDEP}]
	dev-python/zope-configuration[${PYTHON_USEDEP}]
	dev-python/zope-exceptions[${PYTHON_USEDEP}]
	net-zope/zope-i18nmessageid[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	net-zope/zope-location[${PYTHON_USEDEP}]
	net-zope/zope-proxy[${PYTHON_USEDEP}]
	net-zope/zope-schema[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="CHANGES.rst README.rst"
PYTHON_MODULES="${PN/-//}"
