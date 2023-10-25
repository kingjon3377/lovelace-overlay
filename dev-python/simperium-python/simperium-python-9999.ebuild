# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..12} )

inherit distutils-r1 git-r3

DESCRIPTION="Simperium client library for Python"
HOMEPAGE="https://github.com/Simperium/simperium-python"
SRC_URI=""
EGIT_REPO_URI="https://github.com/Simperium/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

PATCHES=( "${FILESDIR}/python3.patch" )
