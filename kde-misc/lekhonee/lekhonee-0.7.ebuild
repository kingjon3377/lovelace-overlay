# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="desktop Wordpress client"
HOMEPAGE="https://fedorahosted.org/lekhonee/"
SRC_URI="https://fedorahosted.org/releases/l/e/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="kde-base/pykde4[${PYTHON_USEDEP}]
	dev-lang/vala:=
	dev-libs/glib:2[${PYTHON_USEDEP}]
	net-libs/libsoup
	dev-libs/libxml2
	x11-libs/gtk+:2
	x11-libs/gtksourceview:2.0
	app-text/gtkspell:2
	net-libs/webkit-gtk:2
	dev-libs/libgee:0.8"
RDEPEND="${DEPEND}"

pkg_postinst() {
	ewarn "The gnome frontend should be a separate package, but I don't know how to disable its installation."
}
