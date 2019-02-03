# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="intelligently extract multiple archive types"
HOMEPAGE="https://brettcsmith.org/2007/dtrx/"
SRC_URI="https://brettcsmith.org/2007/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
