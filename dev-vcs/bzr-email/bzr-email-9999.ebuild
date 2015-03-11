# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DISTUTILS_SRC_TEST=setup.py

inherit distutils bzr

DESCRIPTION="Notification email plugin for Bazaar"
HOMEPAGE="https://launchpad.net/bzr-email"
SRC_URI=""
EBZR_REPO_URI="lp:bzr-email"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-vcs/bzr"
RDEPEND="${DEPEND}"

# setup.py doesn't run tests for some reason
RESTRICT="test"
