# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A super-simple Gtk+ based personal to-do list manager"
HOMEPAGE="http://arr.gr/glista"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/${PN}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="spell"

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	dev-libs/libxml2:2
	spell? ( app-text/gtkspell:2 )
	dev-libs/libunique:1"

DEPEND="${RDEPEND}"
BDEPEND="dev-util/gtk-builder-convert
	virtual/pkgconfig"

DOCS=( README ChangeLog )

src_configure() {
	econf $(use_with spell gtkspell)
}
