# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Utility to test the quality of screens"
HOMEPAGE="https://tobix.github.io/screentest/"
SRC_URI="https://github.com/TobiX/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="x11-libs/gtk+:3
	dev-libs/glib:2"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/xz-utils"

DOCS=( AUTHORS CHANGELOG.md NEW_TESTS.md README.md )

src_configure() {
	meson_src_configure
}
