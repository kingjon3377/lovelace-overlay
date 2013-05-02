# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="desktop Wordpress client"
HOMEPAGE="https://fedorahosted.org/lekhonee/"
SRC_URI="https://fedorahosted.org/releases/l/e/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="kde-base/pykde4
	dev-lang/vala
	dev-libs/glib:2
	net-libs/libsoup
	dev-libs/libxml2
	x11-libs/gtk+:2
	x11-libs/gtksourceview
	app-text/gtkspell
	net-libs/webkit-gtk
	dev-libs/libgee"
RDEPEND="${DEPEND}"

pkg_postinst() {
	ewarn "The gnome frontend should be a separate package, but I don't know how to disable its installation."
}
