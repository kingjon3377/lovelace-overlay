# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MY_PN=TurtleArt

MY_P=${MY_PN}-${PV}

DISTUTILS_GLOBAL_OPTIONS=("--no-sugar")

inherit distutils

DESCRIPTION="a LOGO-like tool for teaching programming"
HOMEPAGE="http://wiki.sugarlabs.org/go/Activities/Turtle_Art"
SRC_URI="http://download.sugarlabs.org/sources/sucrose/fructose/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="as-is"
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

src_prepare() {
	distutils_src_prepare
	ln -s ${PN}.py ${PN}
}
