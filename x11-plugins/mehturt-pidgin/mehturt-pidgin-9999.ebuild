# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 toolchain-funcs

EGIT_REPO_URI="https://github.com/mehturt/pidgin.git"

DESCRIPTION="A collection of pidgin/finch plugins"
HOMEPAGE="https://github.com/mehturt/pidgin"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="net-im/pidgin
	dev-libs/glib:2
	net-libs/libnsl:="
RDEPEND="${DEPEND}"

DOCS=( README.md )

src_prepare() {
	default
	sed -i \
		-e '/^CC=/d' \
		-e 's/^CFLAGS=/CFLAGS+=/' \
		-e 's@~/.purple/plugins@$(DESTDIR)/usr/'"$(get_libdir)"'/purple-2/@g' \
		Makefile || die
}

src_compile() {
	CC="$(tc-getCC)" CFLAGS="${CFLAGS} ${LDFLAGS}" default_src_compile
}

src_install() {
	dodir /usr/$(get_libdir)/purple-2
	default
}
