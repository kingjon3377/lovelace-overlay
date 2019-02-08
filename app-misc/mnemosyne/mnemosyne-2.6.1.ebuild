# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DISTUTILS_SINGLE_IMPL=true
PYTHON_COMPAT=( python3_6 ) # python2_7? python3_5 python3_7
inherit distutils-r1 eutils

DESCRIPTION="Sophisticated flash-card tool also used for long-term memory research"
HOMEPAGE="http://www.mnemosyne-proj.org/"
SRC_URI="mirror://sourceforge/${PN}-proj/${PN}/${P/2a/2}/${P/m/M}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="latex test"

MY_DEPEND="latex? ( app-text/dvipng )
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/cherrypy[${PYTHON_USEDEP}]
	dev-python/webob[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/cheroot[${PYTHON_USEDEP}]"

DEPEND="${DEPEND}
	${MY_DEPEND}
	dev-python/sphinx[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		app-misc/anki[${PYTHON_USEDEP}]
	)"
RDEPEND="${RDEPEND}
	${MY_DEPEND}"

S="${WORKDIR}/${P/m/M}"

pkg_setup() {
	# Required by DISTUTILS_SINGLE_IMPL
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	edos2unix ${PN}.desktop
}

src_test() {
	nosetests || die "Tests failed under ${EPYTHON}"
}
