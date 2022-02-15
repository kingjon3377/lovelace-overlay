# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

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
		dev-python/markdown[${PYTHON_USEDEP}]
		dev-python/wxpython:4.0[${PYTHON_USEDEP}]
		dev-python/pysvg[${PYTHON_USEDEP}]
		dev-python/icalendar[${PYTHON_USEDEP}]
		dev-python/humblewx[${PYTHON_USEDEP}]
	')"
DEPEND="${RDEPEND}
	test? ( $(python_gen_cond_dep '
		dev-python/mock[${PYTHON_USEDEP}]
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
