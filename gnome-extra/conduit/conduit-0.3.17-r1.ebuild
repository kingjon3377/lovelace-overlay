# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils versionator

DESCRIPTION="Synchronization for GNOME"
HOMEPAGE="https://wiki.gnome.org/Conduit"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/conduit/$(get_version_component_range 1-2)/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="nautilus eog totem"

DEPEND="dev-lang/python:2.7
		>=dev-python/pygoocanvas-0.9.0
		>=dev-python/vobject-0.4.8
		>=dev-python/pyxml-0.8.4
		>=dev-python/pygtk-2.10.3
		>=dev-python/dbus-python-0.80"
RDEPEND="${DEPEND}"

src_prepare() {
	default_src_prepare
	echo conduit/modules/TomboyModule.py >> po/POTFILES.skip
}

src_configure() {
	econf \
		$(use_enable nautilus nautilus-extension) \
		$(use_enable eog eog-plugin) \
		$(use_enable totem totem-plugin)
}

src_install() {
	make DESTDIR="${D}" install
}
