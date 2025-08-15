# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

MY_PN=${PN/_/-}
MY_P=${MY_PN}-${PV}
DESCRIPTION="A package with many different plugins for pidgin and libpurple"
HOMEPAGE="https://keep.imfreedom.org/pidgin/purple-plugin-pack/"
SRC_URI="https://downloads.sourceforge.net/pidgin/${MY_PN//-/%20}/${PV}/${MY_P}.tar.xz"

S="${WORKDIR}/${MY_P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls offensive"

RDEPEND="
	dev-libs/json-glib
	net-im/pidgin:=[gui,ncurses]
	app-text/gtkspell:2
	app-text/enchant:2
	dev-libs/glib:2
	sys-libs/zlib
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/pango
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
"

src_configure() {
	local emesonargs=(
		"$(meson_use nls)"
		"$(usex offensive -Dtypes=default,abusive -Dtypes=default)"
	)
	meson_src_configure
}
