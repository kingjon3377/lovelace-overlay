# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="measure and display the rate of data across a network connection"
HOMEPAGE="https://excess.org/speedometer https://github.com/wardi/speedometer"
SRC_URI="https://github.com/wardi/${PN}/archive/refs/tags/release-${PV}.tar.gz -> ${P}.tgz"

S="${WORKDIR}/${PN}-release-${PV}"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-python/urwid[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
