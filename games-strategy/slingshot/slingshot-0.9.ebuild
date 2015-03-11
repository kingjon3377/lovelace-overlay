# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit games python distutils

DESCRIPTION="simple 2D shooting strategy game set in space, with gravity"
HOMEPAGE="http://slingshot.wikispot.org/"
SRC_URI="mirror://debian/pool/main/s/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/pygame"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s:prefix = '/usr/local':prefix = '/usr':" setup.py
}

src_install() {
	distutils_src_install
	doman "${FILESDIR}/${PN}.6"
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
