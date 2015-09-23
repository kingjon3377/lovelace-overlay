# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2 toolchain-funcs eutils cmake-utils

DESCRIPTION="Private digital diary"
HOMEPAGE="http://lifeograph.sourceforge.net"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-cpp/gtkmm:3.0
	dev-cpp/gconfmm
	app-text/gtkspell:3
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
