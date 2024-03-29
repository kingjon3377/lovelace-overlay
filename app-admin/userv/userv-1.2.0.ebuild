# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# FIXME: This package was split and its version numbers reset around 2006, see
# upstream website

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Program call across trust boundaries"
HOMEPAGE="https://www.chiark.greenend.org.uk/~ian/userv/"
SRC_URI="ftp://ftp.chiark.greenend.org.uk/users/ian/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc"

# TODO: Should this go in BDEPEND instead?
DEPEND="doc? ( app-text/debiandoc-sgml[latex] )"

S="${WORKDIR}/${PN}"

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dodir /usr/sbin /usr/bin
	emake prefix="${D}/usr" mandir="${D}/usr/share/man" etcdir="${D}/etc" \
		docdir="${D}/usr/share/doc/${PF}" install
	use doc && emake prefix="${D}/usr" mandir="${D}/usr/share/man" etcdir="${D}/etc" \
			docdir="${D}/usr/share/doc/${PF}" install-doc
}
