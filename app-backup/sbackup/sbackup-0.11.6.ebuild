# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="SBackup is a simple backup solution intended for desktop use."
HOMEPAGE="https://launchpad.net/sbackup"
SRC_URI="http://launchpad.net/${PN}/0.11/${PV}/+download/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

# "make check" checks for previous installation and aborts if it finds one!
RESTRICT=test

#DEPEND="dev-python/gnome-python"
#DEPEND="dev-python/gnome-python-base:2[${PYTHON_USEDEP}]
DEPEND="dev-python/gnome-python-base:2
	dev-python/gconf-python:2[${PYTHON_USEDEP}]
	dev-python/gnome-vfs-python:2[${PYTHON_USEDEP}]
	dev-python/libgnomecanvas-python:2[${PYTHON_USEDEP}]
	dev-python/libbonobo-python:2[${PYTHON_USEDEP}]
	dev-python/libgnome-python:2[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	app-admin/sudo
	x11-libs/gksu"

src_prepare() {
	sed -i -e "s:share/doc/sbackup:share/doc/${P}:g" setup.py.in || die "sed failed"
	emake fill-templates
	default_src_prepare
}

#src_install() {
#	emake PREFIX=/usr DESTDIR="${D}/usr" sysconf_dir="${D}/etc" \
#		SETUP.PY_OPTS="--root=${D} --install-lib /usr/share/${PN} --no-compile -O0" \
#		install
#}
