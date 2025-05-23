# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..11} )

inherit virtualx python-single-r1

PROJ="thetimelineproj"

DESCRIPTION="Timeline editing software"
HOMEPAGE="https://thetimelineproj.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/${PROJ}/${PROJ}/${PV}/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/markdown[${PYTHON_USEDEP}]
		dev-python/wxpython:4.0[${PYTHON_USEDEP}]
		dev-python/pysvg-py3[${PYTHON_USEDEP}]
		dev-python/icalendar[${PYTHON_USEDEP}]
		dev-python/humblewx[${PYTHON_USEDEP}]
	')"
DEPEND="${RDEPEND}
	test? ( $(python_gen_cond_dep '
		dev-python/mock[${PYTHON_USEDEP}]
	') )"
BDEPEND="app-arch/unzip"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# A test fails
src_test() {
	virtx "${PYTHON}" ./execute-specs.py
}

src_install() {
	sitedir="$(python_get_sitedir)"
	sitedir="${sitedir#${EPREFIX}}"
	insinto "${sitedir}/${PN}"
	doins -r timelinelib/ icons/
	doins ${PN}.py
	python_fix_shebang "${D}/${sitedir}/${PN}/${PN}.py"
	fperms +x "${sitedir}/${PN}/${PN}.py"
	dodir /usr/bin
	dosym "$(python_get_sitedir)/${PN}/${PN}.py" /usr/bin/${PN}
}
