# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 bzr

DESCRIPTION="Notification email plugin for Bazaar"
HOMEPAGE="https://launchpad.net/bzr-email"
SRC_URI=""
EBZR_REPO_URI="lp:bzr-email"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-vcs/bzr[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

# setup.py doesn't run tests for some reason
#RESTRICT="test"

python_test() {
	esetup.py test
}
