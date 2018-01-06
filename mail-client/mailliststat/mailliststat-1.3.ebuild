# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="Displays statistics about mbox files"
HOMEPAGE="http://www.marki-online.net/MLS/"
SRC_URI="http://www.marki-online.net/MLS/mls-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls l10n_de l10n_es l10n_fr l10n_it l10n_pt_BR l10n_sk l10n_sr"

RDEPEND=""
DEPEND="${RDEPEND}
	nls? ( app-text/po4a )"

S="${WORKDIR}/mls-${PV}"

src_prepare() {
	epatch "${FILESDIR}/mailliststat_1.3-5.diff"
	epatch "${FILESDIR}/*patch"
	rm mls_lang.h mls.1
	for lang in de es fr it pt_BR sk sr
	do
		use l10n_${lang} && cp "${FILESDIR}/${lang}.po" po/
	done
	cp "${FILESDIR}/${PN}.pot" po/ || die
	cp "${FILESDIR}/po-Makefile" po/Makefile || die
	cp "${FILESDIR}/${PN}.1" . || die
	cp "${FILESDIR}/man-Makefile" man/Makefile || die
	sed -i -e 's:(DESTDIR)/man:(DESTDIR)/share/man:' -e 's:gcc -D:$(USER_CC) -D:' Makefile || die "sed failed"
	use nls || sed -i -e 's/all: po4a/all:/' man/Makefile || die "sed failed"
}

src_compile() {
	if use nls; then
		emake USER_CC=$(tc-getCC) CFLAGS="${CFLAGS}"
	else
		emake USER_CC=$(tc-getCC) CFLAGS="${CFLAGS}" ${PN}
		emake -C po USER_CC=$(tc-getCC) CFLAGS="${CFLAGS}"
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc HISTORY.mls.txt README.txt "${FILESDIR}"/README.Debian
	dohtml html/*
	docinto examples
	dodoc examples/*
}
