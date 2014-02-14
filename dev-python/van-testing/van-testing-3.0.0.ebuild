# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} python3_{2,3} )

inherit distutils-r1

MY_P="${PN/-/.}"

DESCRIPTION="Layers for zope.testing to simplify test setups"
HOMEPAGE="http://pypi.python.org/pypi/van.testing"
SRC_URI="mirror://pypi/v/${MY_P}/${MY_P}-${PV}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/wsgiintercept[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"
