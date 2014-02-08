# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

MY_P="${PN/-/.}"

DESCRIPTION="Layers for zope.testing to simplify test setups"
HOMEPAGE="http://pypi.python.org/pypi/van.testing"
SRC_URI="mirror://pypi/v/${MY_P}/${MY_P}-${PV}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/wsgiintercept"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"
