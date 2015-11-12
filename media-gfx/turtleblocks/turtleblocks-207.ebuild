# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PN=TurtleBlocks

MY_P=${MY_PN}-${PV}

DISTUTILS_SINGLE_IMPL=yes

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="a LOGO-like tool for teaching programming"
HOMEPAGE="http://wiki.sugarlabs.org/go/Activities/Turtle_Art"
SRC_URI="http://download.sugarlabs.org/sources/sucrose/fructose/TurtleArt/${MY_P}.tar.bz2"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="x11-libs/gtk+:2
	dev-python/gconf-python:2
	dev-python/pygobject:2
	dev-python/gst-python:0.10
	dev-python/pygtk:2
	dev-python/pycurl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	sed -i -e 's/turtleart/turtleblocks/' setup.py
	distutils-r1_python_prepare_all
}

python_configure_all() {
	mydistutilsargs=( --no-sugar )
}

DOCS=( NEWS README.md doc/primitives-with-arguments.md doc/type-system.md )
