# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# It's possible it supports Python 3, but I don't know.
PYTHON_COMPAT=( python2_7 )

inherit python-single-r1 eutils

DESCRIPTION="Novel writing assistance software"
HOMEPAGE="http://launchpad.net/kabikaboo"
SRC_URI="http://launchpad.net/${PN}/current/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# 	dev-python/gtkspell-python[${PYTHON_USEDEP}]
#	dev-python/libgnome-python:2[${PYTHON_USEDEP}]
DEPEND="dev-python/pygtk:2[${PYTHON_USEDEP}]
	dev-python/gtkspell-python
	dev-python/libgnome-python:2
	dev-python/pygtksourceview:2[${PYTHON_USEDEP}]
	dev-python/pygobject:2[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_install() {
	dodoc -r help/*
	insinto $(python_get_sitedir)/${PN}/src
	doins src/*
	insinto $(python_get_sitedir)/${PN}/ui
	doins ui/*
	sed -i -e "s:/usr/share/${PN}:$(python_get_sitedir)/${PN}:g" \
		${PN} || die "sed failed"
	dobin ${PN}
	insinto $(python_get_sitedir)/${PN}
	doins ${PN}.png
	doman man/${PN}.1
	domenu ${PN}.desktop
}
