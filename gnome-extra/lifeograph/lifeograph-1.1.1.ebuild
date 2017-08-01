# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit gnome2 toolchain-funcs eutils cmake-utils

DESCRIPTION="Private digital diary"
HOMEPAGE="http://lifeograph.wikidot.com"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-cpp/gtkmm:2.4
	dev-cpp/gconfmm
	app-text/gtkspell:2
	dev-libs/libgcrypt:0"
RDEPEND="${DEPEND}"

src_configure() {
	tc-export AR CC CPP CXX RANLIB
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

DOCS=( README NEWS AUTHORS )

src_install() {
	cmake-utils_src_install
	doman lifeograph.1
	domenu lifeograph.desktop
}
