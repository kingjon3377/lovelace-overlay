# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="Bazaar plugin for uploading to web servers"
HOMEPAGE="https://launchpad.net/bzr-upload"
SRC_URI="http://launchpad.net/${PN}/${PV/.0}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-vcs/bzr[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
