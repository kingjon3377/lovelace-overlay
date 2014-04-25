# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="A program specializer for C"
HOMEPAGE="http://packages.ubuntu.com/hardy/cmix"
SRC_URI="mirror://ubuntu/pool/universe/c/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="cmix"
SLOT="0"
KEYWORDS="amd64"
IUSE="+install-tests test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( !amd64? ( dev-util/dejagnu ) )"

src_prepare() {
	epatch "${FILESDIR}/cmix_2.0.12-6.diff" "${FILESDIR}/cmix_2.0.12-6_2.diff" \
		"${FILESDIR}/lex-yy.cc.patch" "${FILESDIR}/headers.patch" \
		"${FILESDIR}/fileops.patch" "${FILESDIR}/output.patch" \
		"${FILESDIR}/aloc.patch" "${FILESDIR}/direc.patch"
}

src_configure() {
	STDCPP=$(tc-getCPP) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		default_src_configure
}

src_test() {
	if use amd64; then
		ewarn "The test framework does some CHOST-specific manipulations, and"
		ewarn "aborts in amd64"
	else
		default_src_test
	fi
}

src_install() {
#	sed -i -e 's:prefix          = /usr:prefix          = $(DESTDIR)/usr:' \
#		Makefile.top doc/Makefile doc/manual/Makefile src/speclib/GNUmakefile \
#		src/bindist/GNUmakefile src/cmixshow/GNUmakefile \
#		src/analyzer/GNUmakefile src/GNUmakefile testsuite/GNUmakefile \
#		examples/matrix/Makefile examples/turing/Makefile \
#		examples/ack/Makefile examples/ray/Makefile examples/cint/Makefile \
#		examples/pow/Makefile examples/printf/Makefile examples/Makefile \
#		examples/fft/Makefile examples/binsearch/Makefile Makefile ||
#		die "Fixing sandbox violations failed"
#	emake prefix="${D}/usr" install || die "install failed"
	dodir /usr/$(get_libdir) /usr/share/man
	emake DESTDIR="${D}" STRIPFLAG= install install-examples
	if use install-tests; then
		emake DESTDIR="${D}" STRIPFLAG= -C testsuite install
	fi
	dodoc doc/manual/manual.dvi README Changelog doc/manual/intro-cpe.eps doc/manual/intro-cplx.eps \
		doc/manual/intro-ic.eps README.redistribute ROADMAP src/CODINGSTYLE.txt
}
