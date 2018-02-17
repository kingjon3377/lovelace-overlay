# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EBZR_REPO_URI="lp:bzr-pipeline"

PYTHON_COMPAT=( python2_7 )
inherit bzr distutils-r1

DESCRIPTION="Bazaar plugin for managing a pipeline of changes"
HOMEPAGE="http://bazaar-vcs.org/BzrPipeline"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-vcs/bzr[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
