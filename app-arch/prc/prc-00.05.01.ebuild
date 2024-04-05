# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Tool/library for manipulating Palm PRC/PDB files."
HOMEPAGE="https://djw.org/product/palm/par/index.html"
SRC_URI="https://djw.org/product/palm/par/${PN}.tgz -> ${P}.tgz"

S="${WORKDIR}/${PN}"
LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's@/usr/local/pilot@/usr@' -e 's@/usr/local/bin@/usr/bin@' -e 's@/usr/local/man@/usr/share/man@' \
		-e '/^CC/s/^/#/' -e '/^CFLAGS/s/^/#/' -e '/^LD/s/^/#/' -e '/^AR/s/^/#/' -e '/^RANLIB/s/^/#/' \
		-e 's@$(INSTALL@$(DISTDIR)/&@' -e '/whoami/d' Makefile || die
	default
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LD=$(tc-getCC) LDFLAGS="${LDFLAGS}" AR=$(tc-getAR) RANLIB=$(tc-getRANLIB) par
}

src_install() {
	emake DISTDIR="${D}" install
}
