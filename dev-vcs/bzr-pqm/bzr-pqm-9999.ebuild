# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils bzr

DESCRIPTION="bzr plugin to submit an email to a Patch Queue Manager"
HOMEPAGE="https://launchpad.net/bzr-pqm"
SRC_URI=""
EBZR_REPO_URI="lp:bzr-pqm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+launchpad"

DEPEND="dev-vcs/bzr
	launchpad? ( dev-python/launchpadlib )"
RDEPEND="${DEPEND}"
