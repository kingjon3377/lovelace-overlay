# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# From bug #253783 ; TODO: update, as there's a more recent version.

EAPI=5

inherit eutils

DESCRIPTION="Easystroke is a gesture-recognition application for X11."
HOMEPAGE="http://easystroke.wiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

RDEPEND="dev-cpp/gtkmm
	x11-libs/libXrandr
	x11-apps/xinput
	x11-libs/libXtst
	dev-libs/boost
	dev-libs/dbus-glib"
DEPEND="${RDEPEND}
	dev-util/intltool"

src_compile() {
	emake DESTDIR="${D}" PREFIX="/usr/"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
