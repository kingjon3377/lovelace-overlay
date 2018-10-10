# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/dyskette/seneca.git"
PYTHON_COMPAT=( python3_{4,5,6,7} )
inherit git-r3 meson python-single-r1

DESCRIPTION="EPUB reader for GNOME"
HOMEPAGE="https://github.com/dyskette/seneca"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/pygobject:3[${PYTHON_USEDEP}]
	net-libs/webkit-gtk:4
	dev-python/lxml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-libs/glib"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	sed -i -e 's@False@false@g' -e 's@True@true@g' data/com.github.dyskette.Seneca.desktop.in || die
}

src_configure() {
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

# FIXME: Should install Python stuff under /usr/$(get_libdir)/python*
src_install() {
	meson_src_install
}
