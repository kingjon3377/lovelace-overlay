# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

MY_P="${PN/-/_}"

DESCRIPTION="installs a WSGI application in place of a real URI for testing"
HOMEPAGE="http://code.google.com/p/wsgi-intercept/"
SRC_URI="mirror://pypi/w/${MY_P}/${MY_P}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"
