# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Remote software distribution system"
HOMEPAGE="http://www.magnicomp.com/rdist/rdist.shtml"
SRC_URI="http://www.magnicomp.com/download/rdist/${P}.tar.gz"

LICENSE="BSD"
SLOT="1"
KEYWORDS="x86 amd64"
IUSE="+crypt"

DEPEND="sys-devel/bison"
RDEPEND="crypt? ( virtual/ssh )"

src_prepare() {
	# Change the following #define (10 Mar 2004 agriffis)
	sed -i -e 's/^\(#define ARG_TYPE\).*/\1 ARG_STDARG/' config/os-linux.h \
		|| die "sed ARG_TYPE failed"
	# Linux switched from a.out to ELF years ago...
	sed -i -e 's/^\(#define EXE_TYPE\).*/\1 EXE_ELF/' config/os-linux.h \
		|| die "sed EXE_TYPE failed"
	sed -i -e 's/a\.out/ELF/g' doc/rdist.man || die "sed a.out failed"

	# crypto lovers prefer ssh to rsh
	if use crypt; then
		sed -i -e 's,^\(#define _PATH_REMSH\).*,\1 "/usr/bin/ssh",' \
			config/os-linux.h || die "sed _PATH_REMSH failed"
	fi

	# remove yacc-isms eshewed by modern bisons
	sed -i -e '/^%type/ s/,//g' -e 's/= {/{/g' src/gram.y || die "fixup of gram.y failed"

	# use mkstemp(3) instead of mktemp(3)
	epatch "${FILESDIR}/${P}-mkstemp.patch"
}

src_compile() {
	# pull in <string.h> so strerror() is defined properly (64-bit bug)
	emake DEFS_LOCAL=-DNEED_STRING_H YACC='bison -y'
}

src_install() {
	dodir /usr/bin /usr/share/man/man{1,8}
	emake BIN_GROUP=root BIN_DIR="${D}/usr/bin" MAN_GROUP=root \
		MAN_1_DIR="${D}/usr/share/man/man1" MAN_8_DIR="${D}/usr/share/man/man8" \
		install install.man
}
