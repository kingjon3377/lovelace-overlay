# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="simple personal finance"
HOMEPAGE="https://launchpad.net/wxbanker"
SRC_URI="http://launchpad.net/${PN}/0.8/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/wxpython
	dev-python/python-dateutil
	dev-python/beautifulsoup
	dev-python/numpy
	dev-python/simplejson"
RDEPEND="${DEPEND}"
