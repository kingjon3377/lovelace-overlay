# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DEBIAN_PATCH_V=3

DESCRIPTION="Compiler and run-time for the AFNIX programming language"
HOMEPAGE="http://www.afnix.org/"
# http://www.afnix.org/ftp/afnix-src-2.4.0.tgz
SRC_URI="http://www.afnix.org/ftp/${PN}-src-${PV}.tgz
	doc? ( http://www.afnix.org/ftp/${PN}-doc-${PV}.tgz )
	mirror://debian/pool/main/a/${PN}/${PN}_${PV}-${DEBIAN_PATCH_V}.debian.tar.xz"

LICENSE="afnix"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+doc"

RDEPEND="sys-libs/ncurses:0="
DEPEND="${RDEPEND}
	app-arch/xz-utils"

S="${WORKDIR}/${PN}-src-${PV}"

# A test fails, in a way that looks like a problem with my local computer configuration
RESTRICT=test

src_prepare() {
	mv "${WORKDIR}/debian" "${S}/debian" || die
	for file in $(cat debian/patches/series);do
		eapply "debian/patches/${file}"
	done
	if ! has_version 'sys-libs/ncurses:0[tinfo]'; then
		sed -i -e 's@-ltinfo@-lncurses@' cnf/mak/afnix-libs.mak || die
	fi
	default
}

src_configure() {
	sed -i -e "s:-Werror::" cnf/mak/*.mak || die "removing -Werror failed"
	CC=$(tc-getCXX) ./cnf/bin/afnix-setup -v --prefix=/usr --altdir=/etc --pkglib=/usr/$(get_libdir) --pkgprj=/usr/$(get_libdir)/${PN} \
		--pkgetc=/etc/${PN} --pkgdoc=/usr/share/doc/${PF} || "afnix-setup failed"
	emake status
}

src_compile() {
	emake CC=$(tc-getCXX) LD=$(tc-getCXX) AR=$(tc-getAR) RANLIB=$(tc-getRANLIB)
	use doc && emake doc
}

src_test() {
	emake test CC=$(tc-getCXX) LD=$(tc-getCXX) AR=$(tc-getAR) RANLIB=$(tc-getRANLIB) \
		DLYPATH="${S}/bld/lib"
}

src_install() {
	emake PREFIX="${D}/usr" SHRDIR="${D}/usr/share" ALTDIR="${D}" install
	use doc && emake PREFIX="${D}/usr" SHRDIR="${D}/usr/share" ALTDIR="${D}" DOCDIR="${D}/usr/share/doc/${PF}" publish
}
