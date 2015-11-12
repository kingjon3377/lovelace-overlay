# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 bzr

DESCRIPTION="CVS to Bazaar importer"
HOMEPAGE="https://launchpad.net/bzr-cvsps-import"
SRC_URI=""
EBZR_REPO_URI="lp:bzr-cvsps-import"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-vcs/bzr[${PYTHON_USEDEP}]
	dev-vcs/cvsps:0"
RDEPEND="${DEPEND}"
