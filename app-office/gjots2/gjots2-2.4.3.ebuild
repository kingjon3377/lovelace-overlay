# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit multilib distutils-r1 gnome.org

DESCRIPTION="A graphical (GNOME 2) jotter tool"
HOMEPAGE="http://bhepple.freeshell.org/gjots/"
SRC_URI="http://bhepple.freeshell.org/gjots/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="l10n_en l10n_fr l10n_no l10n_nb l10n_ru l10n_it l10n_cs"

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
