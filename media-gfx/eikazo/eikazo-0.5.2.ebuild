# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="graphical frontend for SANE designed for mass-scanning"
HOMEPAGE="http://eikazo.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P/e/E}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/pygtk:2
	dev-python/imaging[scanner]
	dev-python/pywebkitgtk"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/e/E}"
