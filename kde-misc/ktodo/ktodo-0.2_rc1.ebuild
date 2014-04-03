# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} ) # Don't know if it supports Python 3.

inherit distutils-r1

MY_PV=${PV%1}
MY_P=${PN}-${MY_PV}

DESCRIPTION="to-do application for KDE"
HOMEPAGE="http://sourceforge.net/projects/ktodo"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${MY_P}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/PyQt4[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
