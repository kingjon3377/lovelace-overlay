# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

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

RDEPEND="dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/wxpython:3.0[${PYTHON_USEDEP}]
	dev-python/icalendar[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/pysvg[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/mechanize[${PYTHON_USEDEP}]
	)"

src_test() {
	virtx "${PYTHON}" test/execute-specs.py
}

src_install() {
	insinto $(python_get_sitedir)/${PN}
	doins -r source/timelinelib/ icons/
	doins source/${PN}.py
	python_fix_shebang "${D}"/$(python_get_sitedir)/${PN}/${PN}.py
	fperms +x $(python_get_sitedir)/${PN}/${PN}.py
	dodir /usr/bin
	dosym $(python_get_sitedir)/${PN}/${PN}.py /usr/bin/${PN}
	dodoc AUTHORS README
	dodoc -r doc/*
}
