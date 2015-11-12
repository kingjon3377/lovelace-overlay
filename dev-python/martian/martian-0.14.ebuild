# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.*"
DISTUTILS_SRC_TEST="nosetests"

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="Martian is a library that allows the embedding of configuration information in Python code."
HOMEPAGE="http://pypi.python.org/pypi/martian"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/zope-interface[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( net-zope/zope-testing[${PYTHON_USEDEP}]
			dev-python/nose[${PYTHON_USEDEP}] )"

DOCS="CHANGES.txt CREDITS.txt src/martian/README.txt"

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}

src_install() {
	distutils-r1_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/martian/tests"
	}
	python_foreach_impl delete_tests
}
