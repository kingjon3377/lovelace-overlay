# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gdevilspie/gdevilspie-0.5.ebuild,v 1.2 2014/08/10 20:02:27 slyfox Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="A user friendly interface to the devilspie window matching daemon, to create rules easily"
HOMEPAGE="http://code.google.com/p/gdevilspie/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pygtk:2[${PYTHON_USEDEP}]
	dev-python/libwnck-python[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	x11-misc/devilspie"

PATCHES=( "${FILESDIR}"/xdg_basedirectory.patch )

src_prepare() {
	sed -i -e "s:doc/gdevilspie:doc/${PF}:" setup.py || die
	distutils-r1_src_prepare
}
