# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="McCabe-style function complexity and line counting for C and C++"
HOMEPAGE="https://gitlab.com/pmccabe/pmccabe"
SRC_URI="https://gitlab.com/${PN}/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-v${PV}"

src_prepare() {
	sed -i \
		-e 's|-o root -g root||' \
		-e "s|usr/share/doc/pmccabe|usr/share/doc/${PF}|" \
		Makefile || die "sed failed"
	default
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

DOCS=( NEWS README TODO )
