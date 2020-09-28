# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

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

PATCHES=(
	"${FILESDIR}/mailliststat_1.3-5.diff"
	"${FILESDIR}/10_rename.patch"
	"${FILESDIR}/20_po4a.patch"
	"${FILESDIR}/30_gettext.patch"
	"${FILESDIR}/40_user-agent.patch"
	"${FILESDIR}/50_iconv.patch"
	"${FILESDIR}/60_lowercase-email.patch"
	"${FILESDIR}/70_nostrip.patch"
)

src_prepare() {
	default
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

# TODO: Convert first couple of lines to DOCS=() default_src_install
src_install() {
	emake DESTDIR="${D}" install
	dodoc HISTORY.mls.txt README.txt "${FILESDIR}"/README.Debian
	dodoc -r html examples
}
