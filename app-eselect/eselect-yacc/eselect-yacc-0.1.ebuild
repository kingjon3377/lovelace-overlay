# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="A eselect module to handle yacc symlink"
HOMEPAGE="https://www.gentoo.org"
#SRC_URI="mirrors://gentoo/..."
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 alpha arm hppa ia64 ~mips ppc ppc64 s390 sh sparc ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="app-admin/eselect"

src_install() {
	insinto /usr/share/eselect/modules
	doins "${FILESDIR}"/yacc.eselect || die
}
