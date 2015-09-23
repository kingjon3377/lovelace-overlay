# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fuse-python/fuse-python-0.2_pre2.ebuild,v 1.1 2007/06/17 12:51:13 jmglov Exp $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

KEYWORDS="~x86 ~amd64"
DESCRIPTION="FUSE filesystem that lets you view and edit Wikipedia articles as if they were real files"
HOMEPAGE="http://wikipediafs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="dev-python/fuse-python[${PYTHON_USEDEP}]"

src_compile() {
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install
	cp -r example "${D}/usr/share/doc/${PF}/"
}
