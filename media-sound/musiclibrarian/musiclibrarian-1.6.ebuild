# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="A simple GUI tool to organize collections of music"
HOMEPAGE="http://alioth.debian.org/projects/musiclibrarian"
SRC_URI="mirror://ubuntu/pool/universe/m/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="gnome-base/libglade:2.0
	dev-python/pygtk:2
	dev-python/id3-py
	dev-python/pyao
	dev-python/pymad
	dev-python/pyvorbis"
RDEPEND="${DEPEND}"
