# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

MY_VERSION=${PV/_}
MY_P=ac-woven-${MY_VERSION}

DESCRIPTION="AspectC++ is an AOP extension to C++"
SRC_URI="http://www.aspectc.org/fileadmin/downloads/ac/${MY_VERSION}/${MY_P}.tar.gz"
HOMEPAGE="http://www.aspectc.org/"
RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}
	app-office/lyx"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
IUSE=""

S="${WORKDIR}/${PN}"

src_prepare() {
	# allow parallel makes in all subdirectories
	ls Puma/tools/Makefile || die "file to be patched is missing"
	epatch "${FILESDIR}"/Makefile-jobserver.diff
}

src_compile() {
	unset ROOT
	emake -C Puma/ compile
	emake -C AspectC++/ SHARED=1
	emake -C Ag++/      SHARED=1
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
	cp -r AspectC++/examples "${D}/usr/share/doc/${PF}/"
}
