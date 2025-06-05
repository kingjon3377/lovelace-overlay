# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=true
PYTHON_COMPAT=( python3_{8..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="simple 2D shooting strategy game set in space, with gravity"
HOMEPAGE="https://github.com/ryanakca/slingshot"
SRC_URI="https://github.com/ryanakca/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ryanakca/${PN}/commit/c746c4f1e219d7f4adfae2b4446f14ef76658113.patch -> ${P}-whitespace.patch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="$(python_gen_cond_dep '
		dev-python/pygame[${PYTHON_USEDEP}]
	')"
RDEPEND="${DEPEND}"

PATCHES=(
	"${DISTDIR}/${P}-whitespace.patch"
	"${FILESDIR}/${P}-python3.patch"
	"${FILESDIR}/${P}-python3_2.patch"
)

src_prepare() {
	sed -i -e "s:prefix = '/usr/local':prefix = '/usr':" setup.py || die
	default
}

src_install() {
	distutils-r1_src_install
	doman "${FILESDIR}/${PN}.6"
}
