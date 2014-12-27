# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )
inherit git-r3 python-single-r1 eutils

DESCRIPTION="Desktop integration for PivotalTracker web task tracking service"
HOMEPAGE="https://github.com/mimpse/gtracker"
EGIT_REPO_URI="https://github.com/mimpse/gtracker.git"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome-keyring +libnotify +dbus linguas_pt_BR"

RDEPEND="${PYTHON_DEPS}
	dev-python/pygobject:2[${PYTHON_USEDEP}]
	dev-python/gconf-python:2[${PYTHON_USEDEP}]
	gnome-keyring? ( dev-python/gnome-keyring-python[${PYTHON_USEDEP}] )
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	dbus? ( dev-python/dbus-python[${PYTHON_USEDEP}] )
	libnotify? ( dev-python/notify-python[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"

src_compile() {
	:
}

src_install() {
	insinto $(python_get_sitedir)/${PN}/lib
	doins *.py
	insinto $(python_get_sitedir)/${PN}/images
	doins images/*
	dodir /usr/bin
	dosym ../../$(python_get_sitedir)/${PN}/lib/${PN}.py /usr/bin/${PN}
	if use linguas_pt_BR; then
		insinto /usr/share/locale/pt_BR/LC_MESSAGES/
		doins locale/pt_BR/LC_MESSAGES/${PN}.mo
	fi
	make_desktop_entry /usr/bin/${PN} GTracker $(python_get_sitedir)/${PN}/images/${PN}.png Utility || die
}
