# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils toolchain-funcs

DESCRIPTION="Yacc: Yet Another Compiler-Compiler"
HOMEPAGE="http://dinosaur.compilertools.net/#yacc"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/devel/compiler-tools/${P}.tar.Z"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm ~arm64 hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="app-eselect/eselect-yacc"
RDEPEND=""

PATCHES=(
	# mkstemp patch from byacc ebuild
	"${FILESDIR}"/${P}-mkstemp.patch

	# The following patch fixes yacc to run correctly on ia64 (and
	# other 64-bit arches).  See bug 46233
	"${FILESDIR}"/${P}-ia64.patch

	# avoid stack access error, bug 232005
	"${FILESDIR}"/${P}-CVE-2008-3196.patch
)

src_prepare() {
	default

	# Use our CFLAGS and LDFLAGS
	sed -i -e 's: -O : $(CFLAGS) $(LDFLAGS) :' Makefile || die 'sed failed'
}

src_compile() {
	emake clean
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	newbin "${PN}" "yacc.${PN}"
	doman "${PN}.1"
	dodoc 00README* ACKNOWLEDGEMENTS NEW_FEATURES NO_WARRANTY NOTES README*
}

pkg_postinst() {
	"${ROOT}"/usr/bin/eselect yacc update
}

pkg_postrm() {
	"${ROOT}"/usr/bin/eselect yacc update
}