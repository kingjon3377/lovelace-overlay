# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils bzr

DESCRIPTION="CVS to Bazaar importer"
HOMEPAGE="https://launchpad.net/bzr-cvsps-import"
SRC_URI=""
EBZR_REPO_URI="lp:bzr-cvsps-import"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-vcs/bzr
	dev-vcs/cvsps"
RDEPEND="${DEPEND}"
