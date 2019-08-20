# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="measure and display the rate of data across a network connection"
HOMEPAGE="http://excess.org/speedometer"
SRC_URI="http://excess.org/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/urwid[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
