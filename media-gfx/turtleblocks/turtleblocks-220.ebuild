# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=TurtleBlocks

MY_P=${MY_PN}-${PV}

DISTUTILS_SINGLE_IMPL=yes

PYTHON_COMPAT=( python3_{5..10} )

inherit distutils-r1

DESCRIPTION="a LOGO-like tool for teaching programming"
HOMEPAGE="https://wiki.sugarlabs.org/go/Activities/Turtle_Art"
SRC_URI="https://download.sugarlabs.org/sources/sucrose/fructose/TurtleArt/${MY_P}.tar.bz2"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/gtk+:3
	dev-libs/gobject-introspection[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/gst-python:1.0[${PYTHON_USEDEP}]
		dev-python/pycurl[${PYTHON_USEDEP}]
	')"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	2to3 -w --no-diffs -n TurtleArt/turtleblocks.py TurtleArt/util/configfile.py \
		TurtleArt/util/sugariconify.py || die
	distutils-r1_python_prepare_all
}

python_configure_all() {
	mydistutilsargs=( --no-sugar )
}

src_install() {
	sed -i -e "s@self\\.prefix@'${ED}/usr'@g" setup.py || die
	distutils-r1_src_install
	python_optimize
}

DOCS=( NEWS README.md doc/primitives-with-arguments.md doc/type-system.md )
