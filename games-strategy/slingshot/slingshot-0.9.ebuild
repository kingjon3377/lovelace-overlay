# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

DISTUTILS_SINGLE_IMPL=true
PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="simple 2D shooting strategy game set in space, with gravity"
HOMEPAGE="http://slingshot.wikispot.org/"
SRC_URI="mirror://debian/pool/main/s/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="$(python_gen_cond_dep '
		dev-python/pygame[${PYTHON_MULTI_USEDEP}]
	')"
RDEPEND="${DEPEND}"

python_prepare() {
	sed -i -e "s:prefix = '/usr/local':prefix = '/usr':" setup.py
}

src_install() {
	distutils-r1_src_install
	doman "${FILESDIR}/${PN}.6"
}
