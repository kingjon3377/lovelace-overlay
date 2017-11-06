# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DISTUTILS_SINGLE_IMPL=true
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A simple GUI tool to organize collections of music"
HOMEPAGE="https://alioth.debian.org/projects/musiclibrarian"
SRC_URI="mirror://ubuntu/pool/universe/m/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="gnome-base/libglade:2.0[${PYTHON_USEDEP}]
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	dev-python/id3-py[${PYTHON_USEDEP}]
	dev-python/pyao[${PYTHON_USEDEP}]
	dev-python/pymad[${PYTHON_USEDEP}]
	dev-python/pyvorbis[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
