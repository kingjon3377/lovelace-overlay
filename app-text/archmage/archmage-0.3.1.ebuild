# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Extensible reader/decompiler of files in CHM format"
HOMEPAGE="http://archmage.sourceforge.net"
SRC_URI="https://github.com/dottedmag/archmage/archive/0.3.1.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="apache2 dump"

DEPEND="dev-python/beautifulsoup:python-2[${PYTHON_USEDEP}]
	dev-python/pychm[${PYTHON_USEDEP}]
	apache2? ( www-apache/mod_python[${PYTHON_USEDEP}] )
	dump? ( app-text/htmldoc
		|| ( www-client/lynx www-client/elinks ) )"
RDEPEND="${DEPEND}"

src_prepare() {
	# version isn't in release tarball for some reason
	echo "${PV}" > "${S}/RELEASE-VERSION" || die
}

src_install() {
	distutils-r1_src_install
	doman "${PN}.1"

	if use apache2; then
		insinto /etc/apache2/conf/modules.d
		doins "${FILESDIR}/80_mod_chm.conf"
	fi
}

pkg_postinst() {
	if use apache2; then
		einfo "To use mod_chm to open .chm files, put '-D CHM' in your APACHE2_OPTS"
		einfo
		einfo "Next use"
		einfo "  http://host/foo.chm"
		einfo "to download the .chm file and use"
		einfo "  http://host/foo.chm/ ( <-- mind the trailing slash )"
		einfo "to parse the .chm file with mod_chm."
	fi
}
