# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit python eutils

DESCRIPTION="Novel writing assistance software"
HOMEPAGE="http://launchpad.net/kabikaboo"
SRC_URI="http://launchpad.net/${PN}/current/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/pygtk:2
	dev-python/gtkspell-python
	dev-python/libgnome-python:2
	dev-python/pygtksourceview:2
	dev-python/pygobject:2"
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
