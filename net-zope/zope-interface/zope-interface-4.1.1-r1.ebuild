# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-interface/zope-interface-4.1.1.ebuild,v 1.8 2014/07/23 15:37:40 ago Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy pypy2_0 )

inherit distutils-r1 flag-o-matic

MY_PN=${PN/-/.}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Interfaces for Python"
HOMEPAGE="http://pypi.python.org/pypi/zope.interface"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# net-zope/zope-fixers is required for building with Python 3.
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	app-arch/unzip
	net-zope/zope-event[${PYTHON_USEDEP}]
	net-zope/zope-fixers[$(python_gen_usedep 'python3*')]
	test? ( net-zope/zope-testing[${PYTHON_USEDEP}] )"
RDEPEND=""

S=${WORKDIR}/${MY_P}

python_compile() {
	if [[ ${EPYTHON} != python3* ]]; then
		local CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"
		append-flags -fno-strict-aliasing
	fi

	distutils-r1_python_compile
}

python_test() {
	esetup.py test
}
