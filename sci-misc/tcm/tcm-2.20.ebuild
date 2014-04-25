# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib toolchain-funcs eutils

DESCRIPTION="Toolkit for Conceptual Modeling"
HOMEPAGE="http://wwwhome.cs.utwente.nl/~tcm/"
#SRC_URI="http://www.sourcefiles.org/Programming/Toolkits/${P}.src.tar.gz"
SRC_URI="mirror://ubuntu/pool/universe/t/tcm/${P/-/_}+TSQD.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="x11-libs/motif"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	cd "${WORKDIR}"
	mv -i "tcm-2.20+TSQD.orig" "${P}"
}

src_prepare() {
	cd "${WORKDIR}"
	epatch "${FILESDIR}/tcm_2.20+TSQD-4.2.diff"
	cd "${S}"
	epatch debian/patches/*patch "${FILESDIR}/warnings.patch"
	cp -f "${FILESDIR}/Config.tmpl_gentoo" src/Config.tmpl
#	sed -i -e 's/^libs: staticlibs$/libs: semidynamiclibs/' src/Makefile.gcc
	sed -i -e 's:^extern int errno;$:#include <errno.h>:' src/gl/text2ps.c
	ln -sf Makefile.gcc src/Makefile
	touch src/gl/instances.h
	ln -s ../../CHANGELOG ../../COPYING lib/help
#	sed -i -e 's:libdiagram.a :libdiagram.so :' \
#			-e 's:libeditor.a :libeditor.so :' \
#			-e 's:libgui.a :libgui.so :' \
#			src/sd/gd/Makefile
}

src_configure() {
	export TCM_COMPILE_DIR="${S}"
	export TCM_INSTALL_DIR=/usr
	export "TCM_INSTALL_LIB=/usr/$(get_libdir)/tcm"
	export "CONFIG_INSTALL=/etc/tcm"
	export "TCM_INSTALL_DOC=/usr/share/doc/${PF}"
	export "TCM_INSTALL_SHARE=/usr/share/tcm"
	export "TCM_INSTALL_MAN=/usr/share/man"
	emake clean
	emake depend
}

src_compile() {
	export TCM_COMPILE_DIR="${S}"
	export TCM_INSTALL_DIR=/usr
	export TCM_INSTALL_LIB=/usr/$(get_libdir)
	export CONFIG_INSTALL=/etc/tcm
	export TCM_INSTALL_DOC=/usr/share/doc/${PF}
	export TCM_INSTALL_SHARE=/usr/share/tcm
	export TCM_INSTALL_MAN=/usr/share/man
	export HELP_DIR=${TCM_INSTALL_DOC}/help
	USER_CFLAGS="${CFLAGS} -fPIC"
	USER_CFLAGS="${USER_CFLAGS} -DCONFIG_INSTALL=\"${CONFIG_INSTALL}\""
	USER_CFLAGS="${USER_CFLAGS} -DTCM_INSTALL_DIR=\"${TCM_INSTALL_DIR}\""
	USER_CFLAGS="${USER_CFLAGS} -DTCM_INSTALL_LIB=\"${TCM_INSTALL_LIB}\""
	USER_CFLAGS="${USER_CFLAGS} -DTCM_INSTALL_SHARE=\"${TCM_INSTALL_SHARE}}\""
	USER_CFLAGS="${USER_CFLAGS} -DCONFIG_FILE=\"tcm.conf\""
	USER_CFLAGS="${USER_CFLAGS} -DHELP_DIR=\"${HELP_DIR}\""
	USER_CFLAGS="${USER_CFLAGS} -DCOLOR_FILE=\"colorrgb.txt\""
	USER_CFLAGS="${USER_CFLAGS} -DBANNER_FILE=\"banner.ps\""
	emake -j1 TCM_INSTALL_DIR=/usr USER_CFLAGS="${USER_CFLAGS}" Cc=$(tc-getCC) \
			TCM_COMPILER=$(tc-getCC) CC=$(tc-getCXX) CONFIG_INSTALL=/etc/tcm \
			TCM_INSTALL_DOC=${TCM_INSTALL_DOC} \
			TCM_INSTALL_MAN=${TCM_INSTALL_MAN} \
			TCM_INSTALL_SHARE=${TCM_INSTALL_SHARE} execs
}

src_install() {
	export TCM_COMPILE_DIR="${S}"
	export TCM_INSTALL_DIR=/usr
	export TCM_INSTALL_LIB=/usr/$(get_libdir)
	export CONFIG_INSTALL=/etc/tcm
	export TCM_INSTALL_DOC=/usr/share/doc/${PF}
	export TCM_INSTALL_SHARE=/usr/share/tcm
	export TCM_INSTALL_MAN=/usr/share/man
	export HELP_DIR=${TCM_INSTALL_DOC}/help
	dodoc README CHANGELOG FILEMAP tcm.lsm
	dodir "/usr/share/doc/${PF}/usersguide"
	emake TCM_INSTALL_DIR="${D}/${TCM_INSTALL_DIR}" \
			CONFIG_INSTALL="${D}/${CONFIG_INSTALL}" \
			TCM_INSTALL_DOC="${D}/${TCM_INSTALL_DOC}" \
			TCM_INSTALL_SHARE="${D}/${TCM_INSTALL_SHARE}" \
			TCM_INSTALL_MAN="${D}/${TCM_INSTALL_MAN}" \
			install
	rm "${D}"/usr/*
	rm "${D}/${TCM_INSTALL_MAN}/windex"
	[ "${TCM_INSTALL_MAN}" = /usr/man ] || rm -r "${D}/usr/man"
	find "${D}/${CONFIG_INSTALL}" -type f -exec chmod -x \{\} +
	mv "${D}/usr/share/tcm/help" "${D}/usr/share/doc/${PF}/help"
#	doman man/man1/*
#	for dir in bin lib src doc;do
#		emake -C ${dir} "TCM_INSTALL_DOC=${D}/usr/share/doc/${PF}" \
#				"TCM_INSTALL_LIB=${D}/usr/$(get_libdir)/tcm" \
#				"CONFIG_INSTALL=${D}/etc/tcm" \
#				"TCM_INSTALL_SHARE=${D}/usr/share/tcm" \
#				"TCM_INSTALL_MAN=${D}/usr/share/man" \
#				"TCM_INSTALL_DIR=${D}/usr" CHMOD=chmod install
#	done
}
