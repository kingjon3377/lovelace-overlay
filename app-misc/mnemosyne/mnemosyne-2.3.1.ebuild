# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

#DISTUTILS_SINGLE_IMPL=true
PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="Sophisticated flash-card tool also used for long-term memory research"
HOMEPAGE="http://www.mnemosyne-proj.org/"
SRC_URI="mirror://sourceforge/${PN}-proj/${PN}/${P/2a/2}/${P/m/M}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="latex"

MY_DEPEND="latex? ( app-text/dvipng )
	dev-python/PyQt4[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/cherrypy[${PYTHON_USEDEP}]"

DEPEND="${DEPEND}
	${MY_DEPEND}"
RDEPEND="${RDEPEND}
	${MY_DEPEND}"

S="${WORKDIR}/${P/m/M}"
