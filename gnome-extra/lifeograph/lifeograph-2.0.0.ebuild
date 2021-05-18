# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2 toolchain-funcs meson desktop

DESCRIPTION="Private digital diary"
HOMEPAGE="http://lifeograph.sourceforge.net"
SRC_URI="https://launchpad.net/lifeograph/trunk/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-cpp/atkmm
	dev-cpp/cairomm
	media-libs/libchamplain[gtk]
	media-libs/clutter-gtk:1.0
	dev-cpp/gtkmm:3.0
	app-text/enchant:2
	app-text/gtkspell:3
	dev-libs/libgcrypt:0
	dev-cpp/glibmm:2
	dev-cpp/pangomm:1.4
	dev-libs/libsigc++:2"
DEPEND="${DEPEND}
	app-arch/xz-utils"

DOCS=( README NEWS AUTHORS )

src_install() {
	meson_src_install
}
