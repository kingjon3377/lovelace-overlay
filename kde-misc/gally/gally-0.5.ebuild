# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="teaches sign languages"
HOMEPAGE="http://launchpad.net/gally"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P/-/_}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="kde-base/pykde4
	dev-python/PyQt4[phonon]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/-/_}.orig"
