# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="Bazaar plugin to grep files and history"
HOMEPAGE="https://launchpad.net/bzr-grep"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}-final/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-vcs/bzr[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

# make check fails
RESTRICT="test"
