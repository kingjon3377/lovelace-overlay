# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.4"

inherit gnome2 python

DESCRIPTION="User-friendly database application"
HOMEPAGE="http://www.glom.org/wiki/index.php?title=Glom"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="postgres sqlite test"

RDEPEND="
	>=dev-libs/glib-2.24:2
	>=dev-cpp/glibmm-2
	>=dev-cpp/libxmlpp-2.23.1
	>=dev-libs/libxslt-1.1.10
	>=dev-python/pygobject-2.29:3
	>=dev-cpp/libgdamm-4.99.6:5
	gnome-extra/libgda:5[postgres,mysql]
	dev-cpp/gtkmm:3.0
	>=net-libs/libepc-0.4
	>=dev-cpp/goocanvasmm-1.90.8:2.0
	>=app-text/evince-3.0
	app-text/iso-codes
	>=dev-cpp/gtksourceviewmm-3:3.0
	dev-libs/boost[python]
	postgres? ( dev-db/postgresql:=[server] )
"
# FIXME: is postgres-server really needed ?
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=sys-devel/gettext-0.17
	>=app-text/gnome-doc-utils-0.9
	dev-python/sphinx
	test? ( gnome-extra/libgda:5[introspection] )
"

pkg_setup() {
	python_set_active_version 2

	G2CONF="${G2CONF}
		--disable-update-mime-database
		--disable-scrollkeeper
		--disable-client-only
		--enable-glom-ui
		--with-boost-python=boost_python-${PYTHON_ABI}
		$(use_enable sqlite)
		$(use_enable postgres postgresql)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	python_pkg_setup
}
