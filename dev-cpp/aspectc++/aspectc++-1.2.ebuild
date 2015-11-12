# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils toolchain-funcs

MY_VERSION=${PV/_}
MY_P=ac-woven-${MY_VERSION}

DESCRIPTION="AspectC++ is an AOP extension to C++"
SRC_URI="ftp://akut.aspectc.org/releases/${MY_VERSION}/${MY_P}.tar.gz"
HOMEPAGE="http://www.aspectc.org/"
RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}
	app-office/lyx"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
# TODO: add USE=debug, and if set pass TARGET=linux as an option to each
# 'emake' call ... but that will probably change the location of the binaries
# we should 'dobin'.
IUSE=""

S="${WORKDIR}/${PN}"

src_prepare() {
	# allow parallel makes in all subdirectories
	ls Puma/tools/Makefile || die "file to be patched is missing"
	epatch "${FILESDIR}"/Makefile-jobserver.diff
}

src_compile() {
	unset ROOT
	emake -C Puma/ compile CXX=$(tc-getCXX)
	emake -C AspectC++/ SHARED=1 CXX=$(tc-getCXX)
	emake -C Ag++/      SHARED=1 CXX=$(tc-getCXX)
}

src_install() {
	dobin Ag++/bin/linux-release/ag++
	dobin AspectC++/bin/linux-release/ac++

	newdoc README README.main
	newdoc AspectC++/README README.AspectC++
	newdoc Puma/README README.Puma
	newdoc Ag++/TODO.txt TODO.Ag++.txt
	newdoc Puma/TODO TODO.Puma.txt
	dodoc AspectC++/doc/CompilerManual/CompilerManual.pdf \
		AspectC++/doc/LanguageReference/LanguageReference.pdf \
		AspectC++/doc/NoE_ExecModelSurvey/ac++exec-survey.pdf \
		AspectC++/doc/NoE_ShortSurvey/ac++lang-survey.pdf \
		AspectC++/doc/ProgrammingGuide/ProgrammingGuide.lyx \
		AspectC++/doc/QuickRef/ac++quickref.pdf \
		Ag++/doc/Ag++Manual/Ag++Manual.pdf Puma/doc/UsersManual/UsersManual.pdf
	dohtml Puma/doc/lemon/lemon.html

	ewarn "Should convert the Programming Guide to a destination format,"
	ewarn "and perhaps the others to more useful formats than PDF."
	ewarn
	ewarn "We may be missing some docs that were added in 1.2."
	cp -r AspectC++/examples "${D}/usr/share/doc/${PF}/"
}
