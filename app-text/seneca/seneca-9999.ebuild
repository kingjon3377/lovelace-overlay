# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/dyskette/seneca.git"
PYTHON_COMPAT=( python3_{8..12} )
inherit git-r3 meson python-single-r1

DESCRIPTION="EPUB reader for GNOME"
HOMEPAGE="https://github.com/dyskette/seneca"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
	')
	net-libs/webkit-gtk:4
	"
DEPEND="${RDEPEND}
	dev-libs/glib"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

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
