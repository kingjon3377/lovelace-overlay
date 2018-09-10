# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Remote software distribution system"
HOMEPAGE="https://www.magnicomp.com/products/rdist/rdist.shtml"
SRC_URI="https://www.magnicomp.com/download/rdist/${P/_/-}.tar.gz"

LICENSE="BSD"
SLOT="1"
KEYWORDS="x86 amd64"
IUSE="+crypt"

DEPEND="sys-devel/bison"
RDEPEND="crypt? ( virtual/ssh )"

S="${WORKDIR}/${P/_/-}"

src_prepare() {
	# remove yacc-isms eschewed by modern bisons
	sed -i -e '/^%type/ s/,//g' -e 's/= {/{/g' src/gram.y || die "fixup of gram.y failed"

	sed -i -e 's#^\(mandir[ \t]*=[ \t]*\)@mandir@$#\1$(DESTDIR)/usr/share/man#' mf/Vars.mf.in || die

	default
}
