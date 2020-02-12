# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_5,3_6,3_7} )
inherit distutils-r1

DESCRIPTION="Library for interacting with DICTD servers"
HOMEPAGE="gopher://quux.org/1/devel/dictclient."
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S="${WORKDIR}/${PN}"

DOCS=( ${PN}.txt ${PN}.html )

PATCHES=( "${FILESDIR}/${P}-python3.patch" )
