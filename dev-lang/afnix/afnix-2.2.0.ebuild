# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator

DESCRIPTION="Compiler and run-time for the AFNIX programming language"
HOMEPAGE="http://www.afnix.org/"
SRC_URI="http://www.afnix.org/ftp/${PN}-src-$(replace_all_version_separators -).tgz
	doc? ( http://www.afnix.org/ftp/${PN}-doc-$(replace_all_version_separators -).tgz )"

LICENSE="afnix"
SLOT="0"
KEYWORDS="amd64"
IUSE="+doc"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-src-$(replace_all_version_separators -)"

src_configure() {
	sed -i -e "s:-Werror::" cnf/mak/*.mak || die "removing -Werror failed"
	./cnf/bin/afnix-setup -v --prefix=/usr --altdir=/etc || "afnix-setup failed"
	emake status
}

src_compile() {
	emake
	use doc && emake doc
}

src_test() {
	emake test
}

src_install() {
	emake PREFIX="${D}/usr" SHRDIR="${D}/usr/share" ALTDIR="${D}" install
	use doc && emake PREFIX="${D}/usr" SHRDIR="${D}/usr/share" ALTDIR="${D}" DOCDIR="${D}/usr/share/doc/${P}" publish
}
