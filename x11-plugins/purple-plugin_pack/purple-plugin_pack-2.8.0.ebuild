# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

MY_PN=${PN/_/-}
MY_P=${MY_PN}-${PV}
DESCRIPTION="A package with many different plugins for pidgin and libpurple"
HOMEPAGE="https://keep.imfreedom.org/pidgin/purple-plugin-pack/"
SRC_URI="https://downloads.sourceforge.net/pidgin/${MY_PN//-/%20}/${PV}/${MY_P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls offensive"

RDEPEND="
	dev-libs/json-glib
	net-im/pidgin[gtk,ncurses]
	app-text/gtkspell:2
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local emesonargs=(
		"$(meson_use nls)"
		"$(usex offensive -Dtypes=default,abusive -Dtypes=default)"
	)
	meson_src_configure
}
