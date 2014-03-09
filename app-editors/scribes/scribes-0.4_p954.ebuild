# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="2:2.6"
GCONF_DEBUG=no

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit autotools eutils gnome2 python-single-r1

DESCRIPTION="a text editor that is simple, slim and sleek, yet powerful."
HOMEPAGE="http://scribes.sourceforge.net"

MY_P="${P/_p/-dev-build}"

SRC_URI="http://launchpad.net/scribes/0.4/scribes-milestone1/+download/${MY_P}.tar.bz2"

S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	gnome-base/gconf[${PYTHON_USEDEP}]
	gnome-extra/yelp-tools
	dev-libs/dbus-glib
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pygtk[${PYTHON_USEDEP}]
	dev-python/gtkspell-python
	dev-python/pygtksourceview[${PYTHON_USEDEP}]"
	#dev-python/gtkspell-python[${PYTHON_USEDEP}]
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	virtual/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog CONTRIBUTORS NEWS README TODO TRANSLATORS"

pkg_setup() {
	python-single-r1_pkg_setup
	G2CONF="--disable-scrollkeeper"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-sandbox.patch
	sed -i -e '/^[ 	][ 	]*python -OO compile.py[ 	]*$/d' Makefile.am || die
	eautoreconf

	ln -nfs $(type -P true) py-compile || die
	python_fix_shebang .

	gnome2_src_prepare
	echo SCRIBES/SaveSystem/ExternalProcess/TextEncoder.py >> po/POTFILES.skip
}

src_configure() {
	python_export_best
	default_src_configure
}

src_install() {
	gnome2_src_install -j1 am__py_compile=/bin/true
}

pkg_postinst() {
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
}
