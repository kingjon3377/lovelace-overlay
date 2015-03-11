# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/yacc/yacc-1.9.1-r5.ebuild,v 1.2 2012/09/26 07:34:45 ulm Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Yacc: Yet Another Compiler-Compiler"
HOMEPAGE="http://dinosaur.compilertools.net/#yacc"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/devel/compiler-tools/${P}.tar.Z"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="app-admin/eselect-yacc"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Use our CFLAGS and LDFLAGS
	sed -i -e 's: -O : $(CFLAGS) $(LDFLAGS) :' Makefile || die 'sed failed'

	# mkstemp patch from byacc ebuild
	epatch "${FILESDIR}"/mkstemp.patch

	# The following patch fixes yacc to run correctly on ia64 (and
	# other 64-bit arches).  See bug 46233
	epatch "${FILESDIR}"/${P}-ia64.patch

	# avoid stack access error, bug 232005
	epatch "${FILESDIR}"/${P}-CVE-2008-3196.patch
}

src_compile() {
	emake clean || die
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	newbin yacc yacc.yacc || die
	doman yacc.1
	dodoc 00README* ACKNOWLEDGEMENTS NEW_FEATURES NO_WARRANTY NOTES README*
}

pkg_postinst() {
	"${ROOT}"/usr/bin/eselect yacc update
}

pkg_postrm() {
	"${ROOT}"/usr/bin/eselect yacc update
}
