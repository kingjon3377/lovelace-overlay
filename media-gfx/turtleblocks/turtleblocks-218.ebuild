# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN=TurtleBlocks

MY_P=${MY_PN}-${PV}

DISTUTILS_SINGLE_IMPL=yes

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="a LOGO-like tool for teaching programming"
HOMEPAGE="https://wiki.sugarlabs.org/go/Activities/Turtle_Art"
SRC_URI="https://download.sugarlabs.org/sources/sucrose/fructose/TurtleArt/${MY_P}.tar.bz2"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/gtk+:2
	dev-python/gconf-python:2[${PYTHON_USEDEP}]
	dev-python/pygobject:2[${PYTHON_USEDEP}]
	dev-python/gst-python:1.0[${PYTHON_USEDEP}]
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	dev-python/pycurl[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	sed -i -e 's@in path@in os.listdir(path)@' setup.py || die
	distutils-r1_python_prepare_all
}

python_configure_all() {
	mydistutilsargs=( --no-sugar )
}

DOCS=( NEWS README.md doc/primitives-with-arguments.md doc/type-system.md )