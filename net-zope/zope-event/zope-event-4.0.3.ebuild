# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} pypy2_0 )
DISTUTILS_SRC_TEST="nosetests"

inherit distutils-r1

MY_PN=${PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Very basic event publishing system"
HOMEPAGE="http://pypi.python.org/pypi/zope.event"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

#RDEPEND="net-zope/namespaces-zope[zope]"
RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx )"

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN/-//}"

src_compile() {
	distutils-r1_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		emake html
		popd > /dev/null
	fi
}

src_install() {
	distutils-r1_src_install

	if use doc; then
		pushd docs/_build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
