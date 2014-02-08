# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

inherit distutils

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
	dev-python/pytz
	dev-python/restrictedpython
	net-zope/zope-component
	net-zope/zope-configuration
	net-zope/zope-exceptions
	net-zope/zope-i18nmessageid
	net-zope/zope-interface
	net-zope/zope-location
	net-zope/zope-proxy
	net-zope/zope-schema"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN/-//}"

src_install() {
	distutils_src_install
	python_clean_installation_image
}
