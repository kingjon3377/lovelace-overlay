# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit versionator toolchain-funcs

DESCRIPTION="Compiler and run-time for the AFNIX programming language"
HOMEPAGE="http://www.afnix.org/"
# http://www.afnix.org/ftp/afnix-src-2.4.0.tgz
SRC_URI="http://www.afnix.org/ftp/${PN}-src-${PV}.tgz
	doc? ( http://www.afnix.org/ftp/${PN}-doc-${PV}.tgz )"

LICENSE="afnix"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+doc"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-src-${PV}"

src_configure() {
	sed -i -e "s:-Werror::" cnf/mak/*.mak || die "removing -Werror failed"
	./cnf/bin/afnix-setup -v --prefix=/usr --altdir=/etc || "afnix-setup failed"
	emake status
}

src_compile() {
	emake CC=$(tc-getCXX) LD=$(tc-getCXX) STDCCFLAGS="${CXXFLAGS}" AR=$(tc-getAR) RANLIB=$(tc-getRANLIB)
	use doc && emake doc
}

src_test() {
	emake test CC=$(tc-getCXX) LD=$(tc-getCXX) STDCCFLAGS="${CXXFLAGS}" AR=$(tc-getAR) RANLIB=$(tc-getRANLIB)
}

src_install() {
	emake PREFIX="${D}/usr" SHRDIR="${D}/usr/share" ALTDIR="${D}" install
	use doc && emake PREFIX="${D}/usr" SHRDIR="${D}/usr/share" ALTDIR="${D}" DOCDIR="${D}/usr/share/doc/${PF}" publish
}
