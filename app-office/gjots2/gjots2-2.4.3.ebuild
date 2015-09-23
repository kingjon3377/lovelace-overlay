# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/bhepple/fun/sf/g/gjots/gjots2.ebuild,v 1.7.2.23 2012-06-02 12:42:57 bhepple Exp $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit multilib distutils-r1 gnome.org

DESCRIPTION="A graphical (GNOME 2) jotter tool"
HOMEPAGE="http://bhepple.freeshell.org/gjots/"
SRC_URI="http://bhepple.freeshell.org/gjots/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="linguas_en linguas_fr linguas_no linguas_nb linguas_ru linguas_it linguas_cs"

DEPEND="gnome-base/libglade:2.0[${PYTHON_USEDEP}]
	gnome-base/libgnome
	dev-python/gnome-python-base:2
	dev-python/libgnome-python:2[${PYTHON_USEDEP}]
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	dev-python/pyorbit[${PYTHON_USEDEP}]
	dev-python/pygtksourceview:2[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s@,'bin/gjots2xml','bin/xml2gjots'@@" setup.py || die
	default
}

src_install() {
	distutils-r1_src_install
}
