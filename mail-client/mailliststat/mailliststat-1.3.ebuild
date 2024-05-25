# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Displays statistics about mbox files"
HOMEPAGE="http://www.marki-online.net/MLS/"
SRC_URI="http://www.marki-online.net/MLS/mls-${PV}.tgz"

S="${WORKDIR}/mls-${PV}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

IUSE="nls"
MY_LANGS="de es fr it pt-BR sk sr"
for lang in ${MY_LANGS};do
	IUSE+=" l10n_${lang}"
done

DEPEND="${RDEPEND}
	nls? ( app-text/po4a )"

PATCHES=(
	"${FILESDIR}/mailliststat_1.3-5.diff"
	"${FILESDIR}/10_rename.patch"
	"${FILESDIR}/20_po4a.patch"
	"${FILESDIR}/30_gettext.patch"
	"${FILESDIR}/31_gettext.patch"
	"${FILESDIR}/32_gettext.patch"
	"${FILESDIR}/40_user-agent.patch"
	"${FILESDIR}/50_iconv.patch"
	"${FILESDIR}/60_lowercase-email.patch"
	"${FILESDIR}/70_nostrip.patch"
	"${FILESDIR}/331ca768a3a6f783302e5ac2db8f063eb6c0f973.patch"
)

src_prepare() {
	default
	rm mls_lang.h mls.1
	mkdir -p po || die
	for lang in de es fr it pt_BR sk sr
	do
		use l10n_${lang/_/-} && cp "${FILESDIR}/${lang}.po" po/
	done
	cp "${FILESDIR}/${PN}.pot" po/ || die
	cp "${FILESDIR}/po-Makefile" po/Makefile || die
	cp "${FILESDIR}/${PN}.1" man || die
	cp "${FILESDIR}/man-Makefile" man/Makefile || die
	sed -i -e 's:(DESTDIR)/man:(DESTDIR)/share/man:' -e 's:gcc -D:$(USER_CC) -D:' Makefile || die "sed failed"
	use nls || sed -i -e 's/all: po4a/all:/' man/Makefile || die "sed failed"
}

src_compile() {
	if use nls; then
		emake USER_CC=$(tc-getCC) CFLAGS="${CFLAGS} -fcommon" LOCALEDIR=/usr/share/locale
	else
		emake USER_CC=$(tc-getCC) CFLAGS="${CFLAGS} -fcommon" LOCALEDIR=/usr/share/locale ${PN}
		emake -C po USER_CC=$(tc-getCC) CFLAGS="${CFLAGS} -fcommon" LOCALEDIR=/usr/share/locale
	fi
}

# TODO: Convert first couple of lines to DOCS=() default_src_install
src_install() {
	emake DESTDIR="${D}/usr" install
	dodoc HISTORY.mls.txt README.txt "${FILESDIR}"/README.Debian
	dodoc -r html examples
}
