# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="AspectC++ is an AOP extension to C++"
SRC_URI="https://aspectc.org/releases/${PV}/ac-${PV}.tar.gz
	mirror://debian/pool/main/a/${PN}/${PN}_${PV}+git20181008-2.debian.tar.xz"
HOMEPAGE="https://www.aspectc.org/"
RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}
	app-office/lyx
	app-arch/xz-utils
	app-text/docbook-sgml-utils"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
# TODO: add USE=debug, and if set pass TARGET=linux as an option to each
# 'emake' call ... but that will probably change the location of the binaries
# we should 'dobin'.
IUSE=""

S="${WORKDIR}/${PN}"

src_prepare() {
	mv "${WORKDIR}/debian" "${S}/debian" || die
	for file in $(cat debian/patches/series);do
		eapply "debian/patches/${file}"
	done
	default
}

src_compile() {
	unset ROOT
	emake -C Puma/ MINI=1 all CXX=$(tc-getCXX)
	# Fix missing-header build failure with FRONTEND=Clang
	cp Puma/src/cpp/PreVisitor.h Puma/src/parser/cparser/CProject.h Puma/src/infos/CAttributeInfo.h \
		Puma/src/scanner/CScanner.h Puma/src/scanner/CCLexer.h Puma/src/infos/CScopeRequest.h \
		Puma/src/scanner/CLexer.h Puma/src/infos/CObjectInfo.h Puma/src/parser/cparser/CTokens.h \
		Puma/src/cpp/PreParser.h Puma/include/Puma/ || die
	# Every unmasked LLVM and Clang on Gentoo is too recent, so the build aborts if FRONTEND=Clang (which is the default)
	emake -C AspectC++/ SHARED=1 all CXX=$(tc-getCXX) FRONTEND=Puma
	emake -C Ag++/ SHARED=1 all CXX=$(tc-getCXX)
	# After bootstrapping, reweave Puma
	emake -C Puma/ clean
	emake -C Puma/ all AC="${S}/AspectC++/bin/linux-release/ac++" EXTENSIONS="acppext gnuext winext" CXX=$(tc-getCXX)
	emake -C AspectC++/ SHARED=1 CXX=$(tc-getCXX) FRONTEND=Puma
	emake -C Ag++/      SHARED=1 CXX=$(tc-getCXX)
	docbook2man debian/ac++.1.sgml || die
	docbook2man debian/ag++.1.sgml || die
	emake -C Puma/ doc
}

src_test() {
	emake -C Ag++/tests/src ACXX="${S}/Ag++/bin/linux-release/ag++" all
	cd Ag++/tests/src || die
	./test || die "test failed"
}

src_install() {
	emake -C Puma PREFIX="${D}/usr" install

	dobin Ag++/bin/linux-release/ag++
	dobin AspectC++/bin/linux-release/ac++

	doman debian/ac++.1 debin/ag++.1

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
		Ag++/doc/Ag++Manual/Ag++Manual.pdf Puma/doc/UsersManual/UsersManual.pdf \
		Puma/doc/lemon/lemon.html

	ewarn "Should convert the Programming Guide to a destination format,"
	ewarn "and perhaps the others to more useful formats than PDF."
	dodir /usr/share/doc/${PF}/examples
	cp -r AspectC++/examples "${D}/usr/share/doc/${PF}/examples/AspectC++"
	cp -r Puma/examples "${D}/usr/share/doc/${PF}/examples/Puma"
}
