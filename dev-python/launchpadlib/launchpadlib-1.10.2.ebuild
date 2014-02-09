# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DISTUTILS_SRC_TEST=setup.py

inherit distutils

DESCRIPTION="Launchpad web services client library"
HOMEPAGE="https://launchpad.net/launchpadlib"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/lazr-restfulclient
	dev-python/lazr-uri
	dev-python/oauth"
RDEPEND="${DEPEND}"
