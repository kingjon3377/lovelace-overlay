# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Random phrases generator based on defined grammar files."
HOMEPAGE="http://www.polygen.org"
SRC_URI="http://www.polygen.org/dist/${P}-20040628-src.zip"
#SRC_URI="http://ftp.de.debian.org/debian/pool/main/p/polygen/polygen_1.0.6.ds2.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="+grm"

COMMON_DEPEND="dev-lang/ocaml"
RDEPEND="${COMMON_DEPEND}"
#	grm? ( app-text/polygen-grm )"
DEPEND="${COMMON_DEPEND}
	app-arch/unzip"

#S="${WORKDIR}/${P}"

src_prepare() {
	epatch "${FILESDIR}/01-dont-regenerate-existing-ofiles.diff" \
		"${FILESDIR}/03-makefile.diff" "${FILESDIR}/04-create-mode.diff" \
		"${FILESDIR}/05-8bit-strings.diff"
}

src_compile() {
	emake -C src
}

src_install() {
	dobin "${S}/src/polygen"
	newbin "${FILESDIR}/polyrun.pl" polyrun
	doman "${FILESDIR}/polyrun.1"
	dodoc "${FILESDIR}/README.Debian"

	einfo "Following Debian, in order to keep the polygen binary as close as"
	einfo "possible to the one upstream distributes, the extension that would"
	einfo "have polygen look for grammar candidates in /usr/share/polygen has"
	einfo "been moved to a wrapper script called polyrun."
	einfo
	einfo "As a consequence, for most polygen invocations you should now use"
	einfo "polyrun instead of polygen."
	einfo
	einfo "Example grammars can be found at"
	einfo "http://people.debian.org/~enrico/polygen-debian"
}
