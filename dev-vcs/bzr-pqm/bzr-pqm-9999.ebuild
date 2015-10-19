# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 bzr

DESCRIPTION="bzr plugin to submit an email to a Patch Queue Manager"
HOMEPAGE="https://launchpad.net/bzr-pqm"
SRC_URI=""
EBZR_REPO_URI="lp:bzr-pqm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+launchpad"

DEPEND="dev-vcs/bzr[${PYTHON_USEDEP}]
	launchpad? ( dev-python/launchpadlib[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}"
