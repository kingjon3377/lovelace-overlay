# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="measure and display the rate of data across a network connection"
HOMEPAGE="https://excess.org/speedometer https://github.com/wardi/speedometer"
SRC_URI="https://github.com/wardi/${PN}/archive/refs/tags/release-${PV}.tar.gz -> ${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/urwid[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-release-${PV}"
