# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_SINGLE_IMPL=true
PYTHON_COMPAT=( python3_{6..8} )
inherit distutils-r1

DESCRIPTION="simple 2D shooting strategy game set in space, with gravity"
HOMEPAGE="https://github.com/ryanakca/slingshot"
SRC_URI="https://github.com/ryanakca/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ryanakca/${PN}/commit/c746c4f1e219d7f4adfae2b4446f14ef76658113.patch -> ${P}-whitespace.patch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="$(python_gen_cond_dep '
		dev-python/pygame[${PYTHON_MULTI_USEDEP}]
	')"
RDEPEND="${DEPEND}"

PATCHES=(
	"${DISTDIR}/${P}-whitespace.patch"
	"${FILESDIR}/${P}-python3.patch"
	"${FILESDIR}/${P}-python3_2.patch"
)

python_prepare() {
	sed -i -e "s:prefix = '/usr/local':prefix = '/usr':" setup.py
}

src_install() {
	distutils-r1_src_install
	doman "${FILESDIR}/${PN}.6"
}
