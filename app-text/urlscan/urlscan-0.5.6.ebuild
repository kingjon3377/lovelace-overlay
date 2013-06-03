# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="Extract and browse the URLs contained in an email"
HOMEPAGE="http://packages.debian.org/urlscan"
SRC_URI="mirror://debian/pool/main/u/${PN}/${PN}_${PV}-0.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/urwid"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install
	doman ${PN}.1
}
