# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
GCONF_DEBUG="no"
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

src_configure() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF} $(use_enable static-libs static)"
	gnome2_src_configure
}
