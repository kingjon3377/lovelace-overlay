# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A super-simple Gtk+ based personal to-do list manager"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/${PN}/${P}.tar.gz"
HOMEPAGE="http://arr.gr/glista"
KEYWORDS="amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="spell"

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	dev-libs/libxml2:2
	spell? ( app-text/gtkspell:2 )
	dev-libs/libunique:1"

DEPEND="${RDEPEND}
	dev-util/gtk-builder-convert
	virtual/pkgconfig"

DOCS=( README ChangeLog )

src_configure() {
	econf $(use_with spell gtkspell)
}
