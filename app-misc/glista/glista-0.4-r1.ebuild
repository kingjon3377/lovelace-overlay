# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A super-simple Gtk+ based personal to-do list manager"
SRC_URI="http://glista.googlecode.com/files/${P}.tar.gz"
HOMEPAGE="http://prematureoptimization.org/glista"
KEYWORDS="amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="spell"

RDEPEND=">=x11-libs/gtk+-2.12
	dev-libs/glib:2
	dev-libs/libxml2
	spell? ( app-text/gtkspell )
	dev-libs/libunique:1"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf $(use_with spell gtkspell)
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README ChangeLog
}
