# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_{6,7} )

inherit virtualx python-single-r1

PROJ="thetimelineproj"

DESCRIPTION="Timeline editing software"
HOMEPAGE="http://thetimelineproj.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PROJ}/${PROJ}/${PV}/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="$(python_gen_cond_dep '
		dev-python/markdown[${PYTHON_MULTI_USEDEP}]
		dev-python/wxpython:3.0[${PYTHON_MULTI_USEDEP}]
		dev-python/pysvg[${PYTHON_MULTI_USEDEP}]
	')"
DEPEND="${RDEPEND}
	test? ( $(python_gen_cond_dep '
		dev-python/mock[${PYTHON_MULTI_USEDEP}]
	') )"

# A test fails
src_test() {
	virtx "${PYTHON}" ./execute-specs.py
}

src_install() {
	insinto $(python_get_sitedir)/${PN}
	doins -r timelinelib/ icons/
	doins ${PN}.py
	python_fix_shebang "${D}"/$(python_get_sitedir)/${PN}/${PN}.py
	fperms +x $(python_get_sitedir)/${PN}/${PN}.py
	dodir /usr/bin
	dosym $(python_get_sitedir)/${PN}/${PN}.py /usr/bin/${PN}
}
