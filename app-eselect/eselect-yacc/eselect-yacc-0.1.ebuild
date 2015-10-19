# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="A eselect module to handle yacc symlink"
HOMEPAGE="www.gentoo.org"
#SRC_URI="mirrors://gentoo/..."
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 alpha arm hppa ia64 mips ppc ppc64 s390 sh sparc ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="app-admin/eselect"

src_install() {
	insinto /usr/share/eselect/modules
	doins "${FILESDIR}"/yacc.eselect || die
}
