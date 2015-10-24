# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

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

DEPEND="x11-libs/motif:0"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	cd "${WORKDIR}"
	mv -i "tcm-2.20+TSQD.orig" "${P}"
}

src_prepare() {
	find . -name Makefile -exec sed -i -e '/DO NOT DELETE THIS LINE/q' {} + || die
	mkdir debian
	cp "${FILESDIR}/Config.tmpl" debian
	while read patch;do
		epatch "${FILESDIR}/${patch}.dpatch"
	done <<-EOF
01_makefile
02_export_png
02_export_png_2
12_quote_system_call
13_fix_flex_compile
15_fix_gcc_4_0
16_gv_preview
20_fix_doc
30_amd64_null
30_amd64_null_2
30_amd64_null_3
30_amd64_null_4
30_amd64_null_5
31_gcc_4_1
	EOF
	epatch "${FILESDIR}/warnings.patch"
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
	make_tcm_menu() {
		$exe=$1
		$title=$2
		$cat=$3
		if [ -z $cat ]; then
			$cat="Applications/Graphics"
		else
			$cat="Applications/Graphics/${cat}"
		fi
		make_desktop_entry "${exe}" "${title}" "" "${cat}"
	}
	make_tcm_menu /usr/bin/tcm "TCM Control Panel" ""
	make_tcm_menu /usr/bin/tgd "TGD - Tool for Generic Diagrams" "TCM Generic Editors"
	make_tcm_menu /usr/bin/tgt "TGT - Tool for Generic Tables" "TCM Generic Editors"
	make_tcm_menu /usr/bin/tgtt "TGTT - Tool for Generic Textual Trees" "TCM Generic Editors"
	make_tcm_menu /usr/bin/tesd "TESD - Tool for Entry Relationship Diagrams" "TCM Structured Analysis Editors"
	make_tcm_menu /usr/bin/tefd "TEFD - Tool for Data and Event Flow Diagrams" "TCM Structured Analysis Editors"
	make_tcm_menu /usr/bin/tstd "TSTD - Tool for State Transition Diagrams (Mealy)" "TCM Structured Analysis Editors"
	make_tcm_menu /usr/bin/ttut "TTUT - Tool for Transaction Use Tables" "TCM Structured Analysis Editors"
	make_tcm_menu /usr/bin/tucd "TUCD - Tool for Use Case Diagrams" "TCM UML Editors"
	make_tcm_menu /usr/bin/tssd "TSSD - Tool for Static Structure Diagrams" "TCM UML Editors"
	make_tcm_menu /usr/bin/tatd "TATD - Tool for Activity Diagrams" "TCM UML Editors"
	make_tcm_menu /usr/bin/tscd "TSCD - Tool for Statechart Diagrams" "TCM UML Editors"
	make_tcm_menu /usr/bin/tsqd "TSQD - Tool for Sequence Diagrams" "TCM UML Editors"
	make_tcm_menu /usr/bin/tcbd "TCBD - Tool for Collaboration Diagrams" "TCM UML Editors"
	make_tcm_menu /usr/bin/tcpd "TCPD - Tool for Component Diagrams" "TCM UML Editors"
	make_tcm_menu /usr/bin/tdpd "TDPD - Tool for Deployment Diagrams" "TCM UML Editors"
	make_tcm_menu /usr/bin/terd "TERD - Tool for Entity Relationship Diagrams (classic)" "TCM Miscellaneous Editors"
	make_tcm_menu /usr/bin/tcrd "TCRD - Tool for Class Relationship Diagrams (obsolete)" "TCM Miscellaneous Editors"
	make_tcm_menu /usr/bin/tdfd "TDFD - Tool for Data Flow Diagrams (subset of TEFD)" "TCM Miscellaneous Editors"
	make_tcm_menu /usr/bin/tpsd "TPSD - Tool for Process Structure Diagrams" "TCM Miscellaneous Editors"
	make_tcm_menu /usr/bin/tsnd "TSND - Tool for System Network Diagrams" "TCM Miscellaneous Editors"
	make_tcm_menu /usr/bin/trpg "TRPG - Tool for Recursive Process Graphs" "TCM Miscellaneous Editors"
	make_tcm_menu /usr/bin/ttdt "TTDT - Tool for Transaction Decomposition Tables" "TCM Miscellaneous Editors"
}
