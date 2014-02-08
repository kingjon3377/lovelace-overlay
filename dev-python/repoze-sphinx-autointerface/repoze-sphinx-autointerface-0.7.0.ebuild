# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Copyright owners: Arfrever Frehtes Taifersar Arahesis

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

MY_PN=${PN/-/\.}
MY_PN=${MY_PN/-/\.}
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Sphinx extension: auto-generates API docs from Zope interfaces"
HOMEPAGE="http://pypi.python.org/pypi/repoze.sphinx.autointerface"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# dev-python/namespaces-repoze[repoze,repoze.sphinx]
RDEPEND="
	dev-python/sphinx
	net-zope/zope-interface"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="CHANGES.txt README.txt TODO.txt"
PYTHON_MODULES="${PN//-//}.py"
