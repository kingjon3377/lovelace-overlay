# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Remote software distribution system"
HOMEPAGE="https://www.magnicomp.com/products/rdist/rdist.shtml"
SRC_URI="https://www.magnicomp.com/download/rdist/${P/_/-}.tar.gz"

LICENSE="BSD"
SLOT="1"
KEYWORDS="amd64 x86"
IUSE="+crypt"

BDEPEND="sys-devel/bison"
RDEPEND="crypt? ( virtual/ssh )"

S="${WORKDIR}/${P/_/-}"

PATCHES=( "${FILESDIR}/${P}-sandbox.patch" )

src_prepare() {
	# remove yacc-isms eschewed by modern bisons
	sed -i -e '/^%type/ s/,//g' -e 's/= {/{/g' src/gram.y || die "fixup of gram.y failed"

	sed -i -e 's#^\(mandir[ \t]*=[ \t]*\)@mandir@$#\1$(DESTDIR)/usr/share/man#' mf/Vars.mf.in || die

	default
}

src_install() {
	dodir /usr/bin /usr/share/man/man{1,8}
	emake BIN_GROUP=root BIN_DIR="${D}/usr/bin" MAN_GROUP=root \
		MAN_1_DIR="${D}/usr/share/man/man1" MAN_8_DIR="${D}/usr/share/man/man8" \
		SBIN_DIR="${D}/usr/sbin" \
		install
}
