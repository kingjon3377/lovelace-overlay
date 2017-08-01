# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.*"

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="Daemon process control library and tools for Unix-based systems"
HOMEPAGE="http://pypi.python.org/pypi/zdaemon"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-zope/zconfig[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS="CHANGES.txt README.txt"

src_install() {
	distutils-r1_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/zdaemon/tests"
	}
	python_foreach_impl delete_tests
}
