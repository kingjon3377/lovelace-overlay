# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="C++ bindings for x11-libs/goocanvas"
HOMEPAGE="http://live.gnome.org/GooCanvas"

LICENSE="LGPL-2.1"
SLOT="2.0"
KEYWORDS="~amd64"
IUSE="static-libs"

RDEPEND="
	>=dev-cpp/glibmm-2.14.2:2
	>=dev-cpp/gtkmm-2.91.3:3.0
	>=x11-libs/goocanvas-2.0.1:2.0
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_configure() {
	gnome2_src_configure $(use_enable static-libs static)
}
