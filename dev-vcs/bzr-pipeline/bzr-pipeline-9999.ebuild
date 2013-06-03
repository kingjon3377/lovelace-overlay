# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EBZR_REPO_URI="lp:bzr-pipeline"

inherit bzr distutils

DESCRIPTION="Bazaar plugin for managing a pipeline of changes"
HOMEPAGE="http://bazaar-vcs.org/BzrPipeline"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-vcs/bzr"
RDEPEND="${DEPEND}"
