# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1 eutils

DESCRIPTION="Ubuntu rapid application development framework"
HOMEPAGE="https://launchpad.net/quickly"
SRC_URI="http://launchpad.net/${PN}/12.10/${PV}/+download/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=">=dev-python/python-distutils-extra-2.18[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

#S=${WORKDIR}/${P}

src_install() {
	distutils-r1_src_install

	# DistUtilsExtra.auto is *so awesome*, it'll install your desktop files
	# before you've written them!
	mv "${D}/usr/share/applications/project_name.desktop" "${D}/usr/share/quickly/templates/ubuntu-project/project_root/project_name.desktop.in"
}
