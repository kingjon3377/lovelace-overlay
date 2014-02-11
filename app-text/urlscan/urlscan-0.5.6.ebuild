# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# It's possible it supports Python 3.
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Extract and browse the URLs contained in an email"
HOMEPAGE="http://packages.debian.org/urlscan"
SRC_URI="mirror://debian/pool/main/u/${PN}/${PN}_${PV}-0.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/urwid[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_install() {
	distutils-r1_src_install
	doman ${PN}.1
}
