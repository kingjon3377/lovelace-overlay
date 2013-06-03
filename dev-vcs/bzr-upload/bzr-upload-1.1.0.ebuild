# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="Bazaar plugin for uploading to web servers"
HOMEPAGE="https://launchpad.net/bzr-upload"
SRC_URI="http://launchpad.net/${PN}/${PV/.0}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-vcs/bzr"
RDEPEND="${DEPEND}"
