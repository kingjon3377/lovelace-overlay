# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs linux-info readme.gentoo-r1

# TODO: Make this actual-PV
MY_PV="20050425"
MY_P="${PN}-gentoo-${MY_PV}"
DESCRIPTION="Java(tm) Binary Kernel Support for Linux"
HOMEPAGE="http://www.linuxhq.com/java.html"
SRC_URI="http://gentooexperimental.org/distfiles/${MY_P}.tar.bz2"

S=${WORKDIR}/${PN}
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
RDEPEND=">=virtual/jre-1.7"

CONFIG_CHECK="BINFMT_MISC"
ERROR_BINFMT_MISC="
You need to have 'Kernel support for MISC binaries'
turned on in your kernel config. It can be either
compiled in or as a module.
"

DOC_CONTENTS='
See http://www.linuxhq.com/java.html
on howto configure binfmt_misc
'

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} javaclassname.c -o javaclassname || die "Failed to compile"
}

src_install() {
	dobin javawrapper jarwrapper javaclassname
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
