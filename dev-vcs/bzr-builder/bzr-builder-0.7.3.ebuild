# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_MODNAME="bzrlib/plugins/builder"

inherit distutils

DESCRIPTION="construct a bzr branch from a recipe"
HOMEPAGE="http://launchpad.net/bzr-builder"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-vcs/bzr
	dev-python/python-debian"
RDEPEND="${DEPEND}"
