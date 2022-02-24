# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..10} )

inherit distutils-r1

DESCRIPTION="intelligently extract multiple archive types"
HOMEPAGE="https://github.com/dtrx-py/dtrx"
SRC_URI="https://github.com/${PN}-py/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

# TODO: run tests, generate man page
