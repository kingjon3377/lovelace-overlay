# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
# fcntl module required.
PYTHON_RESTRICTED_ABIS="*-jython"
# Tests broken with Python 3.
PYTHON_TESTS_RESTRICTED_ABIS="3.*"

inherit distutils

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Basic inter-process locks"
HOMEPAGE="http://pypi.python.org/pypi/zc.lockfile"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

#RDEPEND="net-zope/namespaces-zc[zc]"
RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( net-zope/zope-testing )"

DOCS="doc.txt src/zc/lockfile/CHANGES.txt src/zc/lockfile/README.txt"
PYTHON_MODULES="${PN/-//}"

src_test() {
	testing() {
		python_execute PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" -c "import sys, unittest, zc.lockfile.tests; sys.exit(not unittest.TextTestRunner(verbosity=2).run(zc.lockfile.tests.test_suite()).wasSuccessful())"
	}
	python_execute_function testing
}
